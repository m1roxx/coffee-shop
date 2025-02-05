//
//  Drink.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 03.02.2025.
//

import FirebaseFirestore

struct Drink: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let price: Double
    let imageUrl: String
    let description: String
}
