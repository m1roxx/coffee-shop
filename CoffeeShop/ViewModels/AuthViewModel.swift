//
//  AuthViewModel.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import SwiftUI
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage = ""
    @Published private(set) var isLoading = false
    @Published var isLoggedIn = false 
    
    private let repository: AuthRepositoryProtocol
    private var handle: AuthStateDidChangeListenerHandle?
    
    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
        setupAuthStateListener()
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    private func setupAuthStateListener() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task {
                if user != nil {
                    self?.isLoggedIn = true
                    try await self?.updateCurrentUser()
                } else {
                    self?.isLoggedIn = false
                    self?.user = nil
                }
            }
        }
    }

    private func updateCurrentUser() async throws {
        self.user = try await repository.getCurrentUser()
    }
    
    func signIn(email: String, password: String) {
        Task {
            isLoading = true
            errorMessage = ""
            do {
                user = try await repository.signIn(email: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func signUp(email: String, password: String, name: String) {
        Task {
            isLoading = true
            errorMessage = ""
            do {
                user = try await repository.signUp(email: email, password: password, name: name)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
    
    func signOut() {
        do {
            try repository.signOut()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
