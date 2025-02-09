//
//  Order.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 08.02.2025.
//

import FirebaseFirestore

struct Order: Identifiable, Codable {
    @DocumentID var id: String?
    let userId: String
    let items: [CartItem] 
    let totalPrice: Double
    let createdAt: Date
    
    struct CartItem: Codable {
        let drinkId: String
        let quantity: Int
    }
}
