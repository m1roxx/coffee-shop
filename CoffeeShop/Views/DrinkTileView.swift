import SwiftUI

// Drink Tile Component
struct DrinkTileView: View {
    let drink: Drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image
            Image(systemName: drink.imageName)
                .font(.system(size: 40))
                .foregroundColor(.brown)
                .frame(width: 60, height: 60)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
            
            // Drink Info
            VStack(alignment: .leading, spacing: 4) {
                Text(drink.name)
                    .font(.headline)
                
                Text(drink.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Text("$\(String(format: "%.2f", drink.price))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.brown)
            }
            
            // Order Button
            Button(action: {
                // Add order action here
            }) {
                Text("Add to Order")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.brown)
                    )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}
