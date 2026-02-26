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
        
        ZStack(alignment: .bottom) {
            
            Map(position: $position) {
                
                Marker("Your Location",
                       coordinate: viewModel.userLocation)
                .tint(.green)
                
                Marker("Delivery Partner",
                       coordinate: viewModel.deliveryPartnerLocation)
                .tint(.blue)
                
                if let route = viewModel.route {
                    MapPolyline(route.polyline)
                        .stroke(.green, lineWidth: 5)
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.fetchRoute()
            }
            
            MapOrderDetailsSheet()
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: 300, alignment: .center )

                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 30,
                        topTrailingRadius: 30,
                        style: .continuous
                    )
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.15), radius: 20, y: -5)                    
                    .ignoresSafeArea(edges: .bottom)
                )
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
