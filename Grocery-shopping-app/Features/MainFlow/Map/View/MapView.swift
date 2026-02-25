//
//  MapView.swift
//  Nectar
//
//  Created by tanmaydeep on 25/02/26.
//

import SwiftUI
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct DeliveryTrackingView: View {
    
    private let location = MapLocation(
        coordinate: CLLocationCoordinate2D(
            latitude: 25.22596,
            longitude: 75.89851
        )
    )
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 25.22596,
            longitude: 75.89851
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.01,
                               longitudeDelta: 0.01)
    )
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [location]
        ) { item in
            MapMarker(
                coordinate: item.coordinate,
                tint: .green
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DeliveryTrackingView()
}
