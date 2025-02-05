import SwiftUI

// Favorites View
struct FavoritesView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Favorites")
                    .font(.title)
                    .padding()
                
                // Placeholder content
                Text("No favorites yet")
                    .foregroundColor(.gray)
            }
            .navigationTitle("Favorites")
        }
    }
}
