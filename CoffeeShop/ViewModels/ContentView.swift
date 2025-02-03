//
//  ContentView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 24.01.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.user != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
    ContentView()
}
