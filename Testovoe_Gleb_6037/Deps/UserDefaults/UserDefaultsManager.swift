//
//  UserDefaultsManager.swift
//  Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct UserDefaultsManager {
    func save<T: Codable>(_ value: T, forKey key: QuizType) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(value)
            UserDefaults.standard.set(data, forKey: key.rawValue)
            print("UserDefaultsManager | Successfully saved value for key: \(key.rawValue)")
        } catch {
            print("UserDefaultsManager | Failed to save value for key: \(key.rawValue) | Error: \(error.localizedDescription)")
        }
    }
}

extension UserDefaultsManager: DependencyKey {
    static var liveValue: UserDefaultsManager = .init()
    static var testValue: UserDefaultsManager = .init()
}

extension DependencyValues {
    var userDefaultsManager: UserDefaultsManager {
        get { self[UserDefaultsManager.self] }
        set { self[UserDefaultsManager.self] = newValue }
    }
    
}
