//
//  StylistFocusQuizData.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct StylistFocusQuizData: Identifiable, Codable, Equatable {
    let id: UUID
    let title: String
    let subtitle: String
    var isSelected: Bool
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decode(String.self, forKey: .subtitle)
        self.isSelected = false
        self.id = UUID()
    }
    enum CodingKeys: String, CodingKey {
        case title, subtitle
    }
}
