import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Logo and Welcome Text
                    VStack(spacing: 15) {
                        Image(systemName: "cup.and.saucer.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.brown)
                        
                        Text("Welcome Back!")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Sign in to order your favorite coffee")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    
                    // Input Fields
                    VStack(spacing: 15) {
                        // Email Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.gray)
                                TextField("Enter your email", text: $email)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                        }
                        
                        // Password Field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .foregroundColor(.gray)
                            
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.gray)
                                SecureField("Enter your password", text: $password)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                        }
                    }
                    
                    // Sign In Button
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else {
                        Button(action: {
                            viewModel.signIn(email: email, password: password)
                        }) {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.brown)
                                )
                        }
                    }
                    
                    // Error Message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .font(.callout)
                    }
                    
                    // Sign Up Link
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Don't have an account? ")
                            .foregroundColor(.gray) +
                        Text("Create one")
                            .foregroundColor(.brown)
                            .fontWeight(.semibold)
                    }
                    .padding(.top)
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}
