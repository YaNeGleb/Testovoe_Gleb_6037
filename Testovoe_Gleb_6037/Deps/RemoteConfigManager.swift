//
//  RemoteConfigManager.swift
//  GTestovoe_Gleb_6037App
//
//  Created by Gleb Zabroda on 21.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import FirebaseRemoteConfig
import Foundation
import ComposableArchitecture

class RemoteConfigManager: RemoteConfigProtocol {
    var remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()

    func fetchAndActivate() async throws {
        let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 5
        
        remoteConfig.configSettings = settings
        
        try await remoteConfig.fetchAndActivate()
    }
    func fetchJSONData(for key: Key) -> Data? {
        guard let jsonObject = remoteConfig.configValue(forKey: key.rawValue).jsonValue else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: jsonObject)
    }
}

extension RemoteConfigManager {
    enum Key: String {
        case quizRemoteConfig
    }
}

extension RemoteConfigManager: DependencyKey {
    static var liveValue: RemoteConfigProtocol = RemoteConfigManager()
    static var testValue: RemoteConfigProtocol = MockRemoteConfigManager()
}

extension DependencyValues {
    var remoteConfig: RemoteConfigProtocol {
        get { self[RemoteConfigManager.self] }
        set { self[RemoteConfigManager.self] = newValue }
    }
}


