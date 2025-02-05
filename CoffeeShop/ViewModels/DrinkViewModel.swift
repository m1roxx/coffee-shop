import SwiftUI

@MainActor
final class DrinkViewModel: ObservableObject {
    @Published private(set) var drinks: [Drink] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage = ""
    
    private let repository: DrinkRepositoryProtocol
    
    init(repository: DrinkRepositoryProtocol = DrinkRepository()) {
        self.repository = repository
        Task { await loadDrinks() }
    }
    
    func loadDrinks() async {
        isLoading = true
        do {
            drinks = try await repository.getAllDrinks()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func loadDrinksByCategory(_ category: DrinkCategory) async {
        isLoading = true
        do {
            drinks = try await repository.getDrinksByCategory(category)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
