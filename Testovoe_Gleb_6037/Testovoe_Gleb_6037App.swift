//
//  Testovoe_Gleb_6037App.swift
//  Testovoe_Gleb_6037
//
//  Created by Alex Fedula on 24.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import SwiftUI
import FirebaseCore
import ComposableArchitecture

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct Testovoe_Gleb_6037App: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let store = Store(initialState: IntroScreenFeature.State()) {
        IntroScreenFeature()
    }
    var body: some Scene {
        WindowGroup {
            IntroScreenView(store: store)
        }
    }
}
