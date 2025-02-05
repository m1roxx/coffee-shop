//
//  HomeView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let user = viewModel.user {
                    Text("Welcome, \(user.name)")
                        .font(.title2)
                }
                
                Button("Sign Out", role: .destructive) {
                    viewModel.signOut()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Coffee Shop")
        }
    }
}
