import SwiftUI

struct DrinkTileView: View {
    let drink: Drink
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
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
            
            AsyncImage(url: URL(string: drink.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
            
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
                    .foregroundColor(.customDarkGreen)
            }
            
            Button(action: {
                guard let userId = authViewModel.user?.id,
                      let drinkId = drink.id else { return }
                Task {
                    await cartViewModel.addToCart(userId: userId, drinkId: drinkId)
                }
            }) {
                Text("Add to Order")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.customDarkGreen)
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
            guard let userId = authViewModel.user?.id,
                  let drinkId = drink.id else { return }
            isFavorite = favoritesViewModel.favoriteItems.contains(drinkId)
        }
    }
}
