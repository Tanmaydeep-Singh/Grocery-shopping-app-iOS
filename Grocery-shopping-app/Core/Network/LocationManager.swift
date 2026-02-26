//
//  LocationManager.swift
//  Nectar
//
//  Created by rentamac on 2/14/26.
//

import CoreLocation
import SwiftUI
import Combine

@MainActor
final class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()  

    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    
    @Published var locationName: String = "Detecting..."
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var userCoordinate: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        authorizationStatus = manager.authorizationStatus
        
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.userCoordinate = location.coordinate
        
        geocoder.reverseGeocodeLocation(location){ [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let place = placemarks?.first {
                let area = place.subLocality
                let city = place.locality
                
                self.locationName = [area, city]
                    .compactMap{ $0 }
                    .joined(separator: ", ")
                
                manager.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationName = "Location not available"
    }
    
    func checkPermissionAndRequest() {
        let status = manager.authorizationStatus

        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .denied, .restricted:
            locationName = "Enable location in Settings"

        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()

        @unknown default:
            break
        }
    }
}
