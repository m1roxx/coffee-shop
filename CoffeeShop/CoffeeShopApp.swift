//
//  CoffeeShopApp.swift
//  CoffeeShop
//
//  Created by Ilyas Nugmanov on 24.01.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CoffeeShopApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel())
                .environmentObject(CartViewModel())
                .environmentObject(DrinkViewModel())
                .environmentObject(OrderViewModel()) 
        }
    }
}
