//
//  MapView.swift
//  Nectar
//

import SwiftUI
import MapKit

struct DeliveryTrackingView: View {
    
    @StateObject private var viewModel: MapViewModel
    @State private var position: MapCameraPosition
    @StateObject private var deliveryStore = DeliveryStateStore.shared

    
    
    init(locationManager: LocationManager
         ) {
        
        let vm = MapViewModel(locationManager: locationManager)
        _viewModel = StateObject(wrappedValue: vm)
        
        
        _position = State(
            initialValue: .region(
                MKCoordinateRegion(
                    center: vm.userLocation,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.02,
                        longitudeDelta: 0.02
                    )
                )
            )
        )
    }
    
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
            .onChange(of: deliveryStore.state) { oldState, newState in
                
                guard let newState else { return }
                
                if newState == NectarDeliveryLiveActivityAttributes.DeliveryState.outForDelivery {
                    viewModel.startDriverSimulation()
                }
                
                if newState == NectarDeliveryLiveActivityAttributes.DeliveryState.delivered {
                    viewModel.stopDriverSimulation()
                }
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

