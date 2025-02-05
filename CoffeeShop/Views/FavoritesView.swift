import SwiftUI

struct FavoritesView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @StateObject private var drinkViewModel = DrinkViewModel()
    
    var favoritesDrinks: [Drink] {
        drinkViewModel.drinks.filter { drink in
            favoritesViewModel.favoriteItems.contains(drink.id ?? "")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if favoritesDrinks.isEmpty {
                    Text("No favorites yet")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(favoritesDrinks) { drink in
                                DrinkTileView(drink: drink)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorites")
            .onAppear {
                guard let userId = authViewModel.user?.id else { return }
                Task {
                    await favoritesViewModel.loadFavorites(for: userId)
                    await drinkViewModel.loadDrinks()
                }
            }
            .environmentObject(authViewModel)
            .environmentObject(favoritesViewModel)
        }
    }
}
