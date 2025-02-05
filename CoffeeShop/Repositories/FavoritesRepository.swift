import FirebaseFirestore

protocol FavoritesRepositoryProtocol {
    func addToFavorites(userId: String, drinkId: String) async throws
    func removeFromFavorites(userId: String, drinkId: String) async throws
    func getFavorites(userId: String) async throws -> [String]
}

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let db = Firestore.firestore()
    private let collection = "users"
    
    func addToFavorites(userId: String, drinkId: String) async throws {
        try await db.collection(collection).document(userId).updateData([
            "favorites": FieldValue.arrayUnion([drinkId])
        ])
    }
    
    func removeFromFavorites(userId: String, drinkId: String) async throws {
        try await db.collection(collection).document(userId).updateData([
            "favorites": FieldValue.arrayRemove([drinkId])
        ])
    }
    
    func getFavorites(userId: String) async throws -> [String] {
        let document = try await db.collection(collection).document(userId).getDocument()
        let user = try document.data(as: User.self)
        return user.favorites
    }
}

enum FavoritesRepositoryError: Error {
    case invalidUserID
    case invalidDrinkID
    case favoriteUpdateFailed
}
