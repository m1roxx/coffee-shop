//
//  AuthRepository.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 02.02.2025.
//

import FirebaseAuth
import FirebaseFirestore


protocol AuthRepositoryProtocol {
    func signIn(email: String, password: String) async throws -> User
    func signUp(email: String, password: String, name: String) async throws -> User
    func signOut() throws
    func getCurrentUser() async throws -> User?
}

final class AuthRepository: AuthRepositoryProtocol {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email, password: password)
        return try await fetchUser(uid: result.user.uid)
    }
    
    func signUp(email: String, password: String, name: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email, password: password)
        let user = User(id: result.user.uid, email: email, name: name)
        try await createUserDocument(user)
        return user
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    func getCurrentUser() async throws -> User? {
        guard let firebaseUser = auth.currentUser else { return nil }
        return try await fetchUser(uid: firebaseUser.uid)
    }
    
    private func fetchUser(uid: String) async throws -> User {
        let snapshot = try await db.collection("users").document(uid).getDocument()
        
        guard let user = try? snapshot.data(as: User.self) else {
            throw AuthRepositoryError.userNotFound
        }
        return user
    }
    
    private func createUserDocument(_ user: User) async throws {
        guard let id = user.id else {
            throw AuthRepositoryError.invalidUserID
        }

        try await db.collection("users").document(id).setData(from: user)
    }
}

enum AuthRepositoryError: Error {
    case userNotFound
    case invalidUserID
}
