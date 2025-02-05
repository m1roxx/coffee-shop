import FirebaseFirestore

protocol CartRepositoryProtocol {
    func addToCart(userId: String, drinkId: String) async throws
    func removeFromCart(userId: String, drinkId: String) async throws
    func updateQuantity(userId: String, drinkId: String, quantity: Int) async throws
    func clearCart(userId: String) async throws
    func getCart(userId: String) async throws -> [String: Int]
}

final class CartRepository: CartRepositoryProtocol {
    private let db = Firestore.firestore()
    private let collection = "users"
    
    func addToCart(userId: String, drinkId: String) async throws {
        try await db.collection(collection).document(userId).updateData([
            "cart.\(drinkId)": FieldValue.increment(Int64(1))
        ])
    }
    
    func removeFromCart(userId: String, drinkId: String) async throws {
        try await db.collection(collection).document(userId).updateData([
            "cart.\(drinkId)": FieldValue.delete()
        ])
    }
    
    func updateQuantity(userId: String, drinkId: String, quantity: Int) async throws {
        if quantity <= 0 {
            try await removeFromCart(userId: userId, drinkId: drinkId)
        } else {
            try await db.collection(collection).document(userId).updateData([
                "cart.\(drinkId)": quantity
            ])
        }
    }
    
    func clearCart(userId: String) async throws {
        try await db.collection(collection).document(userId).updateData([
            "cart": [:]
        ])
    }
    
    func getCart(userId: String) async throws -> [String: Int] {
        let document = try await db.collection(collection).document(userId).getDocument()
        let user = try document.data(as: User.self)
        return user.cart
    }
}

enum CartRepositoryError: Error {
    case invalidUserID
    case invalidDrinkID
    case cartUpdateFailed
}
