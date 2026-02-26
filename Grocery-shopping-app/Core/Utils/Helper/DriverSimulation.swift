//
//  DriverSimulation.swift
//  Nectar
//
//  Created by tanmaydeep on 26/02/26.
//


import MapKit
import Combine

final class DriverSimulation {
    
    private var timer: Timer?
    private var currentStep = 0
    private let totalSteps = 100
    
    func startSimulation(
        userLocation: CLLocationCoordinate2D,
        onUpdate: @escaping (CLLocationCoordinate2D) -> Void,
        onCompletion: (() -> Void)? = nil
    ) {
        
        let startLocation = CLLocationCoordinate2D(
            latitude: userLocation.latitude - 0.025,
            longitude: userLocation.longitude - 0.025
        )
        
        currentStep = 0
        onUpdate(startLocation)
        
        let latStep = (userLocation.latitude - startLocation.latitude) / Double(totalSteps)
        let lonStep = (userLocation.longitude - startLocation.longitude) / Double(totalSteps)
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            
            guard let self = self else { return }
            
            if self.currentStep >= self.totalSteps {
                self.timer?.invalidate()
                onCompletion?()
                return
            }
            
            self.currentStep += 1
            
            let newLocation = CLLocationCoordinate2D(
                latitude: startLocation.latitude + latStep * Double(self.currentStep),
                longitude: startLocation.longitude + lonStep * Double(self.currentStep)
            )
            
            DispatchQueue.main.async {
                onUpdate(newLocation)
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
}
