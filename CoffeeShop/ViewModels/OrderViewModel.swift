//
//  OrderViewModel.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 08.02.2025.
//

import SwiftUI

@MainActor
final class OrderViewModel: ObservableObject {
    private let repository: OrderRepositoryProtocol
    
    init(repository: OrderRepositoryProtocol = OrderRepository()) {
        self.repository = repository
    }
    
    func placeOrder(userId: String, cart: [String: Int], totalPrice: Double) async throws {
        try await repository.addOrder(userId: userId, cart: cart, totalPrice: totalPrice)
    }
    
    func fetchOrders(for userId: String) async throws -> [Order] {
        return try await repository.getOrders(for: userId)
    }
}
