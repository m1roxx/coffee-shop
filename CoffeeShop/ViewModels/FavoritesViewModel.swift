import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoriteItems: [String] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage = ""
    
    private let favoritesRepository: FavoritesRepositoryProtocol
    private let drinkRepository: DrinkRepositoryProtocol
    
    init(favoritesRepository: FavoritesRepositoryProtocol = FavoritesRepository(),
         drinkRepository: DrinkRepositoryProtocol = DrinkRepository()) {
        self.favoritesRepository = favoritesRepository
        self.drinkRepository = drinkRepository
    }
    
    func loadFavorites(for userId: String) async {
        isLoading = true
        do {
            favoriteItems = try await favoritesRepository.getFavorites(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func addToFavorites(userId: String, drinkId: String) async {
        isLoading = true
        do {
            try await favoritesRepository.addToFavorites(userId: userId, drinkId: drinkId)
            await loadFavorites(for: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func removeFromFavorites(userId: String, drinkId: String) async {
        isLoading = true
        do {
            try await favoritesRepository.removeFromFavorites(userId: userId, drinkId: drinkId)
            await loadFavorites(for: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
