import SwiftUI

struct CartView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var drinkViewModel: DrinkViewModel
    
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
                if cartViewModel.isLoading {
                    ProgressView()
                } else if cartItems.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(cartItems, id: \.0.id) { (drink, quantity) in
                                CartItemView(
                                    drink: drink,
                                    quantity: quantity,
                                    onQuantityDecrease: {
                                        guard let userId = authViewModel.user?.id,
                                              let drinkId = drink.id else { return }
                                        Task {
                                            await cartViewModel.updateQuantity(
                                                userId: userId,
                                                drinkId: drinkId,
                                                quantity: quantity - 1
                                            )
                                        }
                                    },
                                    onQuantityIncrease: {
                                        guard let userId = authViewModel.user?.id,
                                              let drinkId = drink.id else { return }
                                        Task {
                                            await cartViewModel.updateQuantity(
                                                userId: userId,
                                                drinkId: drinkId,
                                                quantity: quantity + 1
                                            )
                                        }
                                    },
                                    onRemove: {
                                        guard let userId = authViewModel.user?.id,
                                              let drinkId = drink.id else { return }
                                        Task {
                                            await cartViewModel.updateQuantity(
                                                userId: userId,
                                                drinkId: drinkId,
                                                quantity: 0
                                            )
                                        }
                                    }
                                )
                            }
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Text("Total")
                                        .font(.headline)
                                    Spacer()
                                    Text("$\(String(format: "%.2f", totalPrice))")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.brown)
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    // Implement checkout logic
                                }) {
                                    Text("Checkout")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.brown)
                                        .cornerRadius(12)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Cart")
            .task {
                guard let userId = authViewModel.user?.id else { return }
                await cartViewModel.loadCart(for: userId)
                await drinkViewModel.loadDrinks()
            }
        }
    }
}
