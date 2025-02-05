//
//  User.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import FirebaseFirestore

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    let email: String
    let name: String
    var favorites: [String] = [] // Array of Drink IDs
    var cart: [String: Int] = [:] // Dictionary of Drink ID : Quantity
}
