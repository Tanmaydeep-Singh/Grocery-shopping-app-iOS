//
//  HomeView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            Image("CarrotOrange")
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            HStack{
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("Dhaka, Banassre")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black.opacity(0.7))
            }
        }
    }
}

#Preview {
    HomeView()
}
