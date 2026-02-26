//
//  MapView.swift
//  Nectar
//

import SwiftUI
import MapKit

struct DeliveryTrackingView: View {
    @StateObject private var viewModel = MapViewModel()

       @State private var position = MapCameraPosition.region(
           MKCoordinateRegion(
               center: CLLocationCoordinate2D(
                   latitude: 25.22596,
                   longitude: 75.89851
               ),
               span: MKCoordinateSpan(
                   latitudeDelta: 0.02,
                   longitudeDelta: 0.02
               )
           )
       )
       @StateObject private var deliveryStore = DeliveryStateStore.shared
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Map(position: $position) {
                
                // User Marker
                Marker("Your Location",
                       coordinate: viewModel.userLocation)
                    .tint(.green)
                
                // Driver Marker (Dynamic)
                if let driver = viewModel.driverLocation {
                    Marker("Delivery Partner",
                           coordinate: driver)
                        .tint(.blue)
                }
                
                // Route
                if let route = viewModel.route {
                    MapPolyline(route.polyline)
                        .stroke(.green, lineWidth: 5)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                // Show Drivers Location
                    viewModel.fetchRoute()
                
            }
            .onChange(of: viewModel.userLocation.latitude) { _, _ in
                let newLocation = viewModel.userLocation
                
                print("Camera updating to:", newLocation)

                position = .region(
                    MKCoordinateRegion(
                        center: newLocation,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.02,
                            longitudeDelta: 0.02
                        )
                    )
                )
                viewModel.driverLocation = nil
                viewModel.fetchRoute()
            }
            
            // Bottom Sheet
            MapOrderDetailsSheet()
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: 300)
                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 30,
                        topTrailingRadius: 30,
                        style: .continuous
                    )
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.15),
                            radius: 20,
                            y: -5)
                    .ignoresSafeArea(edges: .bottom)
                )
        }
    }
}

