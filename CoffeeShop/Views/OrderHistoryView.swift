import SwiftUI

struct OrderHistoryView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var orderViewModel: OrderViewModel
    @EnvironmentObject var drinkViewModel: DrinkViewModel // Для получения данных о напитках
    
    @State private var orders: [Order] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView()
                } else if orders.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "clock")
                            .font(.system(size: 50))
                            .foregroundColor(.customDarkGreen)
                        Text("No order history")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(orders, id: \.id) { order in
                                OrderCard(order: order, drinks: drinkViewModel.drinks)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Order History")
            .onAppear {
                Task {
                    guard let userId = authViewModel.user?.id else {
                        print("User ID is nil")
                        return
                    }
                    isLoading = true
                    do {
                        orders = try await orderViewModel.fetchOrders(for: userId)
                        await drinkViewModel.loadDrinks() // Загружаем данные о напитках
                    } catch {
                        print("Error fetching orders: \(error)")
                    }
                    isLoading = false
                }
            }
        }
    }
}
