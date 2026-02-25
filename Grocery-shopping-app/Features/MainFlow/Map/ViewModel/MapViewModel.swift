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
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 26.2389, longitude: 73.0243),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager) {
        locationManager.$userCoordinate
            .compactMap { $0 }
            .sink { [weak self] coordinate in
                self?.region.center = coordinate
            }
            .store(in: &cancellables)
    }
    
    
}
