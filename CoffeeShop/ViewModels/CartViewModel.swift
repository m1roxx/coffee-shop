import SwiftUI

@MainActor
final class CartViewModel: ObservableObject {
    @Published private(set) var cartItems: [String: Int] = [:]
    @Published private(set) var isLoading = false
    @Published var errorMessage = ""
    
    private let cartRepository: CartRepositoryProtocol
    private let drinkRepository: DrinkRepositoryProtocol
    
    init(cartRepository: CartRepositoryProtocol = CartRepository(),
         drinkRepository: DrinkRepositoryProtocol = DrinkRepository()) {
        self.cartRepository = cartRepository
        self.drinkRepository = drinkRepository
    }
    
    func loadCart(for userId: String) async {
        isLoading = true
        do {
            cartItems = try await cartRepository.getCart(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addToCart(userId: String, drinkId: String) async {
            print("Debug: Adding to cart - UserID: \(userId), DrinkID: \(drinkId)")
            isLoading = true
            do {
                try await cartRepository.addToCart(userId: userId, drinkId: drinkId)
                await loadCart(for: userId)
                print("Debug: Cart updated successfully")
            } catch {
                print("Debug: Cart Add Error - \(error.localizedDescription)")
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
        
        
    
    
    func removeFromCart(userId: String, drinkId: String) async {
        isLoading = true
        do {
            try await cartRepository.removeFromCart(userId: userId, drinkId: drinkId)
            await loadCart(for: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func updateQuantity(userId: String, drinkId: String, quantity: Int) async {
        isLoading = true
        do {
            try await cartRepository.updateQuantity(userId: userId, drinkId: drinkId, quantity: quantity)
            await loadCart(for: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func clearCart(userId: String) async {
        isLoading = true
        do {
            try await cartRepository.clearCart(userId: userId)
            cartItems = [:]
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
