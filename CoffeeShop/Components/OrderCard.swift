//
//  OrderCard.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 08.02.2025.
//

import SwiftUI

struct OrderCard: View {
    let order: Order
    let drinks: [Drink]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date: \(order.createdAt.formatted(date: .long, time: .shortened))")
                .font(.caption)
                .foregroundColor(.gray)
            
            Divider()
            
            ForEach(order.items, id: \.drinkId) { item in
                if let drink = drinks.first(where: { $0.id == item.drinkId }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(drink.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text("Quantity: \(item.quantity)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("$\(String(format: "%.2f", drink.price * Double(item.quantity)))")
                            .font(.subheadline)
                            .foregroundColor(.customDarkGreen)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Text("Total:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Text("$\(String(format: "%.2f", order.totalPrice))")
                    .font(.headline)
                    .foregroundColor(.customDarkGreen)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
