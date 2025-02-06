import SwiftUI

struct MainTabView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var drinkViewModel = DrinkViewModel()
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
                .tag(1)
            
            CartView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(3)
        }
        .tint(.brown)
        .environmentObject(authViewModel)
        .environmentObject(cartViewModel)
        .environmentObject(drinkViewModel)
        .environmentObject(favoritesViewModel)
    }
}
