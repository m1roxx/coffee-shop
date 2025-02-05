//
//  Drink.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 03.02.2025.
//

import FirebaseFirestore

// Drink Model
struct Drink: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let imageName: String
    let category: DrinkCategory
}

enum DrinkCategory: String, CaseIterable {
    case hot = "Hot Coffee"
    case cold = "Cold Coffee"
    case tea = "Tea"
    case special = "Specials"
}
