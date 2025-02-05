import SwiftUI

struct HomeView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var drinkViewModel = DrinkViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedCategory: DrinkCategory = .hot
    
    var filteredDrinks: [Drink] {
        drinkViewModel.drinks.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = authViewModel.user {
                        // Welcome Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Welcome back,")
                                .font(.title3)
                                .foregroundColor(.gray)
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        
                        // Load favorites and cart when user is available
                        .onAppear {
                            Task {
                                await favoritesViewModel.loadFavorites(for: user.id ?? "")
                                await cartViewModel.loadCart(for: user.id ?? "")
                            }
                        }
                    }
                    
                    // Categories
                    CategorySelectorView(selectedCategory: $selectedCategory)
                        .padding(.vertical)
                    
                    if drinkViewModel.isLoading {
                        ProgressView()
                    } else {
                        // Drinks Grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {
                            ForEach(filteredDrinks) { drink in
                                DrinkTileView(drink: drink)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                authViewModel.signOut()
            }) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(.brown)
            })
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(authViewModel)
        .environmentObject(favoritesViewModel)
        .environmentObject(cartViewModel)
        .onChange(of: selectedCategory) { _ in
            Task {
                await drinkViewModel.loadDrinksByCategory(selectedCategory)
            }
        }
    }
}
