import SwiftUI
// Enhanced Home View
struct HomeView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var selectedCategory: DrinkCategory = .hot
    
    // Sample drinks data
    private let drinks: [Drink] = [
        Drink(name: "Espresso", description: "Strong, pure coffee shot", price: 3.99, imageName: "cup.and.saucer.fill", category: .hot),
        Drink(name: "Cappuccino", description: "Espresso with steamed milk foam", price: 4.99, imageName: "cup.and.saucer.fill", category: .hot),
        Drink(name: "Iced Latte", description: "Espresso with cold milk and ice", price: 5.49, imageName: "cup.and.saucer.fill", category: .cold),
        Drink(name: "Green Tea", description: "Traditional Japanese green tea", price: 3.49, imageName: "leaf.fill", category: .tea),
        // Add more drinks as needed
    ]
    
    var filteredDrinks: [Drink] {
        drinks.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = viewModel.user {
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
                    }
                    
                    // Categories
                    CategorySelectorView(selectedCategory: $selectedCategory)
                        .padding(.vertical)
                    
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
            .navigationBarItems(trailing: Button(action: {
                viewModel.signOut()
            }) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .foregroundColor(.brown)
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

