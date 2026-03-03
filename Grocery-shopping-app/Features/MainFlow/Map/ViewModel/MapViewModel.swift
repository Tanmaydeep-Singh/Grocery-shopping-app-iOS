//
//  MapViewModel.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import MapKit
import Combine
import SwiftUI

@MainActor
final class MapViewModel: ObservableObject {
    static let shared = MapViewModel()
    
    private let defaultLocation = CLLocationCoordinate2D(
        latitude: 25.22596,
        longitude: 75.89851
    )
    
    
    @Published var userLocation: CLLocationCoordinate2D
    @Published var driverLocation: CLLocationCoordinate2D?
    @Published var route: MKRoute?
    
    
    private var cancellables = Set<AnyCancellable>()
    private let simulationHelper = DriverSimulation()
    
    
    private let locationManager = LocationManager.shared

    init() {
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
    
    
    func startDriverSimulation() {
        
        simulationHelper.startSimulation(
            userLocation: userLocation,
            onUpdate: { [weak self] newLocation in
                guard let self else { return }
                
                
                withAnimation(.linear(duration: 0.3)) {
                    self.driverLocation = newLocation
                }
                
                self.fetchRoute()
            },
            onCompletion: {
                print("Driver reached destination")
            }
        )
    }
    
    func stopDriverSimulation() {
        simulationHelper.stop()
    }
    
    
    func fetchRoute() {
        
        if driverLocation == nil {
               driverLocation = CLLocationCoordinate2D(
                   latitude: userLocation.latitude - 0.02,
                   longitude: userLocation.longitude - 0.02
               )
           }
           
           guard let driverLocation else { return }
    
        
        let request = MKDirections.Request()
        
        let sourceItem = MKMapItem(
            location: CLLocation(
                latitude: driverLocation.latitude,
                longitude: driverLocation.longitude
            ),
            address: nil
        )
        
        let destinationItem = MKMapItem(
            location: CLLocation(
                latitude: userLocation.latitude,
                longitude: userLocation.longitude
            ),
            address: nil
        )
        
        request.source = sourceItem
        request.destination = destinationItem
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [weak self] response, error in
            guard let self else { return }
            
            if let route = response?.routes.first {
                DispatchQueue.main.async {
                    self.route = route
                }
            } else if let error {
                print("Route error:", error.localizedDescription)
            }
        }
    }
}
