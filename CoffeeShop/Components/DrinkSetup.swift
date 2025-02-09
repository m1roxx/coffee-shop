//
//  DrinkSetup.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 06.02.2025.
//

import FirebaseStorage
import FirebaseFirestore

class DrinkSetup {
    private let storage = Storage.storage().reference()
    private let db = Firestore.firestore()
    
    func setupInitialDrinks() async throws {
        // Get download URLs for all images
        let drinks = try await createDrinksData()
        
        // Add drinks to Firestore
        for drink in drinks {
            try await db.collection("drinks").addDocument(data: [
                "name": drink.name,
                "description": drink.description,
                "price": drink.price,
                "imageURL": drink.imageURL,
                "category": drink.category.rawValue
            ])
        }
    }
    
    private func getImageURL(for imageName: String) async throws -> String {
        let imageRef = storage.child("drinks/\(imageName)")
        return try await imageRef.downloadURL().absoluteString
    }
    
    private func createDrinksData() async throws -> [Drink] {
        // Hot drinks
        let latteURL = try await getImageURL(for: "latte.jpg")
        let cappuccinoURL = try await getImageURL(for: "cappuccino.jpg")
        let espressoURL = try await getImageURL(for: "long_espresso.jpg")
        let mocaccinoURL = try await getImageURL(for: "white_moccacino.jpg")
        
        // Cold drinks
        let icedMatchaURL = try await getImageURL(for: "iced_matcha_latte.jpg")
        let icedChocolateURL = try await getImageURL(for: "iced_chocolate_dark.jpg")
        let icedBananaURL = try await getImageURL(for: "iced_banana_choco_latte.jpg")
        
        // Tea
        let teaURL = try await getImageURL(for: "tea.jpg")
        let icedTeaURL = try await getImageURL(for: "iced_tea_peach_lemon.jpg")
        
        return [
            // Hot Drinks
            Drink(name: "Latte",
                  description: "Smooth espresso with steamed milk and a light layer of foam",
                  price: 4.99,
                  imageURL: latteURL,
                  category: .hot),
            
            Drink(name: "Cappuccino",
                  description: "Equal parts espresso, steamed milk, and milk foam",
                  price: 4.49,
                  imageURL: cappuccinoURL,
                  category: .hot),
            
            Drink(name: "Long Espresso",
                  description: "Double shot of espresso for an extra kick",
                  price: 3.99,
                  imageURL: espressoURL,
                  category: .hot),
                  
            Drink(name: "White Mocha",
                  description: "Espresso with white chocolate and steamed milk",
                  price: 5.49,
                  imageURL: mocaccinoURL,
                  category: .hot),
            
            // Cold Drinks
            Drink(name: "Iced Matcha Latte",
                  description: "Premium green tea with cold milk over ice",
                  price: 5.99,
                  imageURL: icedMatchaURL,
                  category: .cold),
                  
            Drink(name: "Iced Dark Chocolate",
                  description: "Rich dark chocolate blend served over ice",
                  price: 5.49,
                  imageURL: icedChocolateURL,
                  category: .cold),
                  
            Drink(name: "Iced Banana Chocolate",
                  description: "Chocolate and banana blend with cold milk",
                  price: 6.49,
                  imageURL: icedBananaURL,
                  category: .cold),
            
            // Tea
            Drink(name: "Classic Tea",
                  description: "Your choice of premium loose leaf tea",
                  price: 3.99,
                  imageURL: teaURL,
                  category: .tea),
                  
            Drink(name: "Iced Peach Lemon Tea",
                  description: "Refreshing peach and lemon tea over ice",
                  price: 4.99,
                  imageURL: icedTeaURL,
                  category: .tea)
        ]
    }
}
