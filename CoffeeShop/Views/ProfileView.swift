import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = authViewModel.user {
                        VStack(spacing: 8) {
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top)
                    }
                    
                    VStack(spacing: 15) {
                        Group {
                            NavigationLink(destination: Text("Order History")) {
                                ProfileRowView(
                                    icon: "clock",
                                    title: "Order History",
                                    iconColor: .customDarkGreen
                                )
                            }
                            
                            NavigationLink(destination: Text("Payment Methods")) {
                                ProfileRowView(
                                    icon: "creditcard",
                                    title: "Payment Methods",
                                    iconColor: .customDarkGreen
                                )
                            }
                            
                            NavigationLink(destination: Text("Address")) {
                                ProfileRowView(
                                    icon: "location",
                                    title: "Address",
                                    iconColor: .customDarkGreen
                                )
                            }
                            
                            NavigationLink(destination: Text("Settings")) {
                                ProfileRowView(
                                    icon: "gearshape",
                                    title: "Settings",
                                    iconColor: .customDarkGreen
                                )
                            }
                        }
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                        Button(action: {
                            authViewModel.signOut()
                        }) {
                            ProfileRowView(
                                icon: "rectangle.portrait.and.arrow.right",
                                title: "Sign Out",
                                iconColor: .red
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ProfileRowView: View {
    let icon: String
    let title: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
            
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}
