//
//  MapView.swift
//  Nectar
//

import SwiftUI
import MapKit
import SwiftUI
import MapKit

struct DeliveryTrackingView: View {
    
    @StateObject private var viewModel: MapViewModel
    @State private var showOrderSheet = true
    @State private var position: MapCameraPosition
    
    init(locationManager: LocationManager) {
        let vm = MapViewModel(locationManager: locationManager)
        _viewModel = StateObject(wrappedValue: vm)
        
        _position = State(
            initialValue: .region(
                MKCoordinateRegion(
                    center: vm.userLocation,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.01,
                        longitudeDelta: 0.01
                    )
                )
            )
        )
    }
    
    var body: some View {
        Map(position: $position) {
            
            // User Marker
            Marker("Your Location",
                   coordinate: viewModel.userLocation)
                .tint(.green)
            
            // Delivery Partner Marker
            Marker("Delivery Partner",
                   coordinate: viewModel.deliveryPartnerLocation)
                .tint(.blue)
            
            // Route
            if let route = viewModel.route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchRoute()
        }
//        .onChange(of: viewModel.userLocation) { _, newLocation in
//            withAnimation {
//                position = .region(
//                    MKCoordinateRegion(
//                        center: newLocation,
//                        span: MKCoordinateSpan(
//                            latitudeDelta: 0.01,
//                            longitudeDelta: 0.01
//                        )
//                    )
//                )
//            }
//            viewModel.fetchRoute()
//        }
        .sheet(isPresented: $showOrderSheet) {
            MapOrderDetailsSheet()
                .padding(.top, 20)
                .presentationDetents([.fraction(0.4), .medium, .large])
                .presentationDragIndicator(.visible)
             .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.4)))
        }
    }
}

#Preview {
    DeliveryTrackingView(
        locationManager: {
            let manager = LocationManager()
            manager.userCoordinate = CLLocationCoordinate2D(
                latitude: 25.22596,
                longitude: 75.89851
            )
            return manager
        }()
    )
}
