//
//  HomeView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("Welcome, \(authViewModel.user?.email ?? "Guest")!")
                .font(.title)
            
            Button("Sign Out") {
                authViewModel.signOut()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
    }
}
