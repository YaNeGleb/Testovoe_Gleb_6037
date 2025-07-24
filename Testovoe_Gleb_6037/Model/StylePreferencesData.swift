//
//  StylePreferencesData.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

struct StylePreferencesData: Identifiable, Codable, Equatable {
    let id: UUID
    let imageString: String
    let title: String
    var isSelected: Bool
    var imageURL: URL? {
        URL(string: imageString)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageString = try container.decode(String.self, forKey: .image)
        self.title = try container.decode(String.self, forKey: .title)
        self.isSelected = false
        self.id = UUID()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageString, forKey: .image)
        try container.encode(title, forKey: .title)
    }
    
    enum CodingKeys: String, CodingKey {
        case image, title
    }
}
