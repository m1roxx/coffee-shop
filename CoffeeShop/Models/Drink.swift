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
    let description: String
    let price: Double
    let imageName: String
    let category: DrinkCategory
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageName
        case category
    }
}

enum DrinkCategory: String, Codable, CaseIterable {
    case hot = "Hot Coffee"
    case cold = "Cold Coffee"
    case tea = "Tea"
    case special = "Specials"
}
