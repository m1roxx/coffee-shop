import SwiftUI

// Profile View
struct ProfileView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if let user = viewModel.user {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                Section("Preferences") {
                    NavigationLink(destination: Text("Order History")) {
                        Label("Order History", systemImage: "clock")
                    }
                    
                    NavigationLink(destination: Text("Payment Methods")) {
                        Label("Payment Methods", systemImage: "creditcard")
                    }
                    
                    NavigationLink(destination: Text("Address")) {
                        Label("Address", systemImage: "location")
                    }
                }
                
                Section("Account") {
                    NavigationLink(destination: Text("Settings")) {
                        Label("Settings", systemImage: "gear")
                    }
                    
                    Button(action: {
                        viewModel.signOut()
                    }) {
                        Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

