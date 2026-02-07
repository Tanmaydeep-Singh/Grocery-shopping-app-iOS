//
//  LocationView.swift
//  Nectar
//
//  Created by tanmaydeep on 05/02/26.
//

import SwiftUI

struct LocationView: View {
    @Binding var path: NavigationPath
    @Binding var isLoggedIn: Bool
    
    @State private var selectedZone = "Banasree"
        let zones = ["Banasree", "Gulshan", "Dhanmondi"]
    
    var body: some View {
        VStack {
            
            // Image
            Image("Location")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .padding(40)
            
            
            VStack(spacing: 10) {
                Text("location_title")
                    .font(.system(size: 26, weight: .semibold))
                    .frame(maxWidth: .infinity)
                Text("location_subtitle")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()

                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Zone
                                Text("location_zone")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.secondary)
                                
                                Menu {
                                    ForEach(zones, id: \.self) { zone in
                                        Button(zone) {
                                            selectedZone = zone
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedZone)
                                            .font(.system(size: 18))
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.secondary)
                                    }
                                }
                                
                                Divider()
                    
//                    Area
                    Text("location_area")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Menu {
                        ForEach(zones, id: \.self) { zone in
                            Button(zone) {
                                selectedZone = zone
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedZone)
                                .font(.system(size: 18))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                            
                       
                    
                
                    
                    
                    
                    VStack(spacing: 16){
                        
                        
                        
                        PrimaryButton(title:"Submit"){
                            path.append(OnboardingRoutes.login)
                        }
                        
                    }.padding(.bottom,20)
                }
                .padding(20)
            }
        }
    }
}
#Preview {
    LocationView(path: .constant(NavigationPath()),
                 isLoggedIn: .constant(false)
    
    )
}

