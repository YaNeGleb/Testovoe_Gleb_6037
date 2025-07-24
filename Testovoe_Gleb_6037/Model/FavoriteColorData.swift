//
//  FavoriteColorData.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUICore
import Foundation

struct FavoriteColorData: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let hex: String
    var isSelected: Bool
    var color: Color { Color(hex: hex) }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.hex = try container.decode(String.self, forKey: .hex)
        self.isSelected = false
        self.id = UUID()
    }
    enum CodingKeys: String, CodingKey {
        case name, hex
    }
}
