//
//  OrderRepository.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 08.02.2025.
//

import FirebaseFirestore

protocol OrderRepositoryProtocol {
    func addOrder(userId: String, cart: [String: Int], totalPrice: Double) async throws
    func getOrders(for userId: String) async throws -> [Order]
}

final class OrderRepository: OrderRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func addOrder(userId: String, cart: [String: Int], totalPrice: Double) async throws {
        let items = cart.map { key, value in
            Order.CartItem(drinkId: key, quantity: value)
        }
        
        let orderData: [String: Any] = [
            "userId": userId,
            "items": items.map { ["drinkId": $0.drinkId, "quantity": $0.quantity] }, // Сохраняем как массив словарей
            "totalPrice": totalPrice,
            "createdAt": Timestamp(date: Date())
        ]
        
        try await db.collection("users").document(userId).collection("orders").addDocument(data: orderData)
    }
    
    func getOrders(for userId: String) async throws -> [Order] {
        let snapshot = try await db.collection("users").document(userId).collection("orders").getDocuments()
        
        let orders = snapshot.documents.compactMap { document in
            do {
                let order = try document.data(as: Order.self)
                print("Fetched order: \(order)")
                return order
            } catch {
                print("Error decoding order: \(error)")
                return nil
            }
        }
        
        return orders
    }
}
