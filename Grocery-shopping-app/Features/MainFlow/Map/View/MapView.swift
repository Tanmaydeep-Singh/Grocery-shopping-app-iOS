//
//  MapView.swift
//  Nectar
//

import SwiftUI
import MapKit

struct DeliveryTrackingView: View {
    
    
    @State private var route: MKRoute?
    @State private var showOrderSheet = true
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 25.22596,
                longitude: 75.89851
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
    )
    
    
     let userLocation = CLLocationCoordinate2D(
        latitude: 25.22596,
        longitude: 75.89851
    )
    
     let deliveryPartnerLocation = CLLocationCoordinate2D(
        latitude: 25.23596,
        longitude: 75.88851
    )
    
    
    var body: some View {
        Map(position: $position) {
            
            // User Location
            Marker("Your Location",
                   coordinate: userLocation)
                .tint(.green)
            
            // Delivery Partner
            Marker("Delivery Partner",
                   coordinate: deliveryPartnerLocation)
                .tint(.blue)
            
            // Road Route
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            fetchRoute()
        }
        .sheet(isPresented: $showOrderSheet) {
            MapOrderDetailsSheet()
                .presentationDetents([.fraction(0.4), .medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
    
    private func fetchRoute() {
        let request = MKDirections.Request()
        
        let sourcePlacemark = MKPlacemark(coordinate: deliveryPartnerLocation)
        let destinationPlacemark = MKPlacemark(coordinate: userLocation)
        
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                
//                withAnimation {
//                                self.position = .rect(route.polyline.boundingMapRect)
//                            }
              
            } else if let error {
                print("Route error:", error.localizedDescription)
            }
        }
    }
}

#Preview {
    DeliveryTrackingView()
}
