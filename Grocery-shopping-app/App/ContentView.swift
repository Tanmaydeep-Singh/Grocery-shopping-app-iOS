//
//  ContentView.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

        var body: some View {
            Group {
                if authViewModel.user != nil {
                    MainView()
                } else {
                    AuthFlowView()
                }
            }
        }
    }

    #Preview {
        ContentView()
            .environmentObject(AuthViewModel())
    }
