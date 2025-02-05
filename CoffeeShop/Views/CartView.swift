import SwiftUI

// Cart View



struct CartView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Your Cart")
                    .font(.title)
                    .padding()
                
                // Placeholder content
                Text("Cart is empty")
                    .foregroundColor(.gray)
                
                Spacer()
                
                // Checkout button
                Button(action: {
                    // Add checkout action
                }) {
                    Text("Checkout")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.brown)
                        )
                        .padding()
                }
            }
            .navigationTitle("Cart")
        }
    }
}
