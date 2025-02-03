//
//  LoginView.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign In") {
                Task { await authViewModel.signIn(email: email, password: password) }
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
