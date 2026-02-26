//
//  MapViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import MapKit
import Combine

@MainActor
final class MapViewModel: ObservableObject {
    
    private let defaultLocation = CLLocationCoordinate2D(
        latitude: 25.22596,
        longitude: 75.89851
    )
    
    @Published var userLocation: CLLocationCoordinate2D
    @Published var route: MKRoute?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        
        // Start with default
        self.userLocation = defaultLocation
        
        locationManager.$userCoordinate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] coordinate in
                guard let self else { return }
                
                if let coordinate {
                    self.userLocation = coordinate
                } else {
                    self.userLocation = self.defaultLocation
                }
            }
            .store(in: &cancellables)
    }
    
    /// Delivery partner is slightly behind user location
    var deliveryPartnerLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: userLocation.latitude - 0.01,
            longitude: userLocation.longitude - 0.01
        )
    }
    
    /// Fetch route between delivery partner and user
    func fetchRoute() {
        let request = MKDirections.Request()
        
        request.source = MKMapItem(
            placemark: MKPlacemark(coordinate: deliveryPartnerLocation)
        )
        
        request.destination = MKMapItem(
            placemark: MKPlacemark(coordinate: userLocation)
        )
        
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [weak self] response, error in
            guard let self else { return }
            
            if let route = response?.routes.first {
                self.route = route
            } else if let error {
                print("Route error:", error.localizedDescription)
            }
        }
    }
}
