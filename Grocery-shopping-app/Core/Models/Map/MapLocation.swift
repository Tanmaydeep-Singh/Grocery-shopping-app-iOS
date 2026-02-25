//
//  MapLocation.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import Foundation
import MapKit


struct MapLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
