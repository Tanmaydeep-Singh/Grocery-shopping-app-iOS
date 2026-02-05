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
                Text("select_location_title")
                    .font(.system(size: 26, weight: .semibold))
                    .frame(maxWidth: .infinity)
                Text("select_location_subtitle")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()

                
                VStack(alignment: .leading, spacing: 20) {
                    
                    
                    // Zone
                                Text("your_zone")
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
                    Text("your_area")
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
                        
                        
                        
                        Button {
                            isLoggedIn.toggle()
                        } label: {
                            Text("Submit")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                        }
                        .background(Color("Splash"))
                        .cornerRadius(12)
                        .padding(.vertical , 10)
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

