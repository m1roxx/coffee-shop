import SwiftUI

struct CartItemView: View {
    let drink: Drink
    let quantity: Int
    let onQuantityDecrease: () -> Void
    let onQuantityIncrease: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: drink.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(drink.name)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: onRemove) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                    }
                }
                
                Text(drink.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                HStack {
                    Text("$\(String(format: "%.2f", drink.price))")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryGreen)
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button(action: onQuantityDecrease) {
                            Image(systemName: "minus.circle.fill")
                                .foregroundColor(.primaryGreen)
                        }
                        
                        Text("\(quantity)")
                            .font(.headline)
                            .frame(minWidth: 30)
                        
                        Button(action: onQuantityIncrease) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.primaryGreen)
                        }
                    }
                }
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
