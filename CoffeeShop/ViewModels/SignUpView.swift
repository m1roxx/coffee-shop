//
//  SignUpView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign Up") {
                guard password == confirmPassword else {
                    authViewModel.errorMessage = "Passwords don't match"
                    return
                }
                Task { await authViewModel.signUp(email: email, password: password) }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            if !authViewModel.errorMessage.isEmpty {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
