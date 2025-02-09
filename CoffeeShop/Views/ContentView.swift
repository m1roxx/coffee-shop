//
//  ContentView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 24.01.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.user != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(CartViewModel())
        .environmentObject(DrinkViewModel())
        .environmentObject(OrderViewModel())
}
