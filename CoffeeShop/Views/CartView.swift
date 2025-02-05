import SwiftUI

struct CartView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var drinkViewModel = DrinkViewModel()
    
    var cartItems: [(Drink, Int)] {
        drinkViewModel.drinks
            .filter { drink in cartViewModel.cartItems.keys.contains(drink.id ?? "") }
            .compactMap { drink in
                guard let quantity = cartViewModel.cartItems[drink.id ?? ""] else { return nil }
                return (drink, quantity)
            }
    }
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + $1.0.price * Double($1.1) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if cartItems.isEmpty {
                    Text("Cart is empty")
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(cartItems, id: \.0.id) { (drink, quantity) in
                                HStack {
                                    DrinkTileView(drink: drink)
                                    
                                    VStack {
                                        Text("Quantity: \(quantity)")
                                        
                                        HStack {
                                            Button("-") {
                                                guard let userId = authViewModel.user?.id, let drinkId = drink.id else { return }
                                                Task {
                                                    await cartViewModel.updateQuantity(userId: userId, drinkId: drinkId, quantity: quantity - 1)
                                                }
                                            }
                                            
                                            Button("+") {
                                                guard let userId = authViewModel.user?.id, let drinkId = drink.id else { return }
                                                Task {
                                                    await cartViewModel.updateQuantity(userId: userId, drinkId: drinkId, quantity: quantity + 1)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            Text("Total: $\(String(format: "%.2f", totalPrice))")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Button("Checkout") {
                                // Implement checkout logic
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Cart")
            .onAppear {
                guard let userId = authViewModel.user?.id else { return }
                Task {
                    await cartViewModel.loadCart(for: userId)
                    await drinkViewModel.loadDrinks()
                }
            }
            .environmentObject(authViewModel)
            .environmentObject(cartViewModel)
        }
    }
}
