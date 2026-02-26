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
    private let stepInterval: TimeInterval = 3.0
    
    func startSimulation(
        userLocation: CLLocationCoordinate2D,
        onUpdate: @escaping (CLLocationCoordinate2D) -> Void,
        onCompletion: (() -> Void)? = nil
    ) {
        
        stop() // 🔥 Prevent duplicate timers
        
        let startLocation = CLLocationCoordinate2D(
            latitude: userLocation.latitude - 0.02,
            longitude: userLocation.longitude - 0.02
        )
        
        currentStep = 0
        onUpdate(startLocation)
        
        let latStep = (userLocation.latitude - startLocation.latitude) / Double(totalSteps)
        let lonStep = (userLocation.longitude - startLocation.longitude) / Double(totalSteps)
        
        timer = Timer(timeInterval: stepInterval, repeats: true) { [weak self] _ in
            
            guard let self else { return }
            
            self.currentStep += 1
            
            if self.currentStep > self.totalSteps {
                self.stop()
                onUpdate(userLocation)   // 🔥 ensure exact final location
                onCompletion?()
                return
            }
            
            let newLocation = CLLocationCoordinate2D(
                latitude: startLocation.latitude + latStep * Double(self.currentStep),
                longitude: startLocation.longitude + lonStep * Double(self.currentStep)
            )
            
            onUpdate(newLocation)
        }
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        currentStep = 0
    }
}
