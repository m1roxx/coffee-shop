//
//  DrinkRepository.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 05.02.2025.
//

import FirebaseFirestore

protocol DrinkRepositoryProtocol {
    func getAllDrinks() async throws -> [Drink]
    func getDrinksByCategory(_ category: DrinkCategory) async throws -> [Drink]
    func addDrink(_ drink: Drink) async throws
    func updateDrink(_ drink: Drink) async throws
    func deleteDrink(_ id: String) async throws
}

final class DrinkRepository: DrinkRepositoryProtocol {
    private let db = Firestore.firestore()
    private let collection = "drinks"
    
    func getAllDrinks() async throws -> [Drink] {
        let snapshot = try await db.collection(collection).getDocuments()
        return try snapshot.documents.compactMap { document in
            try document.data(as: Drink.self)
        }
    }
    
    func getDrinksByCategory(_ category: DrinkCategory) async throws -> [Drink] {
        let snapshot = try await db.collection(collection)
            .whereField("category", isEqualTo: category.rawValue)
            .getDocuments()
        
        return try snapshot.documents.compactMap { document in
            try document.data(as: Drink.self)
        }
    }
    
    func addDrink(_ drink: Drink) async throws {
        try await db.collection(collection).document().setData(from: drink)
    }
    
    func updateDrink(_ drink: Drink) async throws {
        guard let id = drink.id else { throw DrinkRepositoryError.invalidDrinkID }
        try await db.collection(collection).document(id).setData(from: drink)
    }
    
    func deleteDrink(_ id: String) async throws {
        try await db.collection(collection).document(id).delete()
    }
}

enum DrinkRepositoryError: Error {
    case invalidDrinkID
}
