
import SwiftUI
struct DrinkTileView: View {
    
    let drink: Drink
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Favorite Button Overlay
            HStack {
                Spacer()
                Button(action: {
                    guard let userId = authViewModel.user?.id else { return }
                    Task {
                        if isFavorite {
                            await favoritesViewModel.removeFromFavorites(userId: userId, drinkId: drink.id ?? "")
                        } else {
                            await favoritesViewModel.addToFavorites(userId: userId, drinkId: drink.id ?? "")
                        }
                        isFavorite.toggle()
                    }
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                }
                .padding(8)
            }
            
            // Image
            AsyncImage(url: URL(string: drink.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120) // Увеличили размер с 60x60 до 120x120
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120) // Также изменили размер placeholder
            }
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
                guard let userId = authViewModel.user?.id, let drinkId = drink.id else {
                    print("Debug: Missing userId or drinkId")
                    return
                }
                Task {
                    do {
                        await cartViewModel.addToCart(userId: userId, drinkId: drinkId)
                    } catch {
                        print("Debug: Cart Add Error - \(error.localizedDescription)")
                    }
                }
            }){
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
        .onAppear {
            guard let userId = authViewModel.user?.id, let drinkId = drink.id else { return }
            isFavorite = favoritesViewModel.favoriteItems.contains(drinkId)
        }
    }
}
