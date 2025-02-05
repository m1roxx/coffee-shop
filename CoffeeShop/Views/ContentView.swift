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
}
#Preview {
    DrinkTileView(drink: Drink(id: "1", name: "Espresso", description: "Strong coffee", price: 3.5, imageName: "cup.and.saucer", category: .hot))
        .environmentObject(AuthViewModel())
        .environmentObject(FavoritesViewModel())
        .environmentObject(CartViewModel())
}
