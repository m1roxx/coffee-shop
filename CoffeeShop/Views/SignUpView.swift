import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Header
                VStack(spacing: 12) {
                    Text("Create Account")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Join us to order amazing coffee")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top)
                
                // Input Fields
                VStack(spacing: 15) {
                    // Name Field
                    InputField(
                        title: "Name",
                        placeholder: "Enter your name",
                        text: $name,
                        icon: "person"
                    )
                    
                    // Email Field
                    InputField(
                        title: "Email",
                        placeholder: "Enter your email",
                        text: $email,
                        icon: "envelope"
                    )
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    
                    // Password Fields
                    InputField(
                        title: "Password",
                        placeholder: "Create a password",
                        text: $password,
                        icon: "lock",
                        isSecure: true
                    )
                    
                    InputField(
                        title: "Confirm Password",
                        placeholder: "Confirm your password",
                        text: $confirmPassword,
                        icon: "lock.shield",
                        isSecure: true
                    )
                }
                
                // Sign Up Button
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: {
                        guard password == confirmPassword else {
                            viewModel.errorMessage = "Passwords don't match"
                            return
                        }
                        viewModel.signUp(email: email, password: password, name: name)
                    }) {
                        Text("Create Account")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.primaryGreen)
                            )
                    }
                }
                
                // Error Message
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .font(.callout)
                }
                
                // Sign In Link
                Button(action: { dismiss() }) {
                    Text("Already have an account? ")
                        .foregroundColor(.gray) +
                    Text("Sign In")
                        .foregroundColor(.accentGreen)
                        .fontWeight(.semibold)
                }
                .padding(.top)
            }
            .padding(.horizontal)
        }
    }
}
