//
//  RemoteConfigProtocol.swift
//  Testovoe_Gleb_6037App
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ComposableArchitecture

protocol RemoteConfigProtocol {
    func fetchAndActivate() async throws
    func fetchJSONData(for key: RemoteConfigManager.Key) -> Data?
}
