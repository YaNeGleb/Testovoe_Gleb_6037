//
//  QuizItem.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 23.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUICore

struct QuizItem: Equatable, Codable {
    let type: QuizType
    let title: String
    let subtitle: String?
    let navigationTitle: String
    var options: QuizOptions

    enum QuizOptions: Equatable, Codable {
        case favoriteColors([FavoriteColorData])
        case stylePreferences([StylePreferencesData])
        case stylistFocuses([StylistFocusQuizData])
        
        func toggleItem(at id: UUID) -> Self {
            switch self {
            case .favoriteColors(var items):
                if let index = items.firstIndex(where: { $0.id == id }) {
                    items[index].isSelected.toggle()
                }
                return .favoriteColors(items)
            case .stylePreferences(var items):
                if let index = items.firstIndex(where: { $0.id == id }) {
                    items[index].isSelected.toggle()
                }
                return .stylePreferences(items)
            case .stylistFocuses(var items):
                if let index = items.firstIndex(where: { $0.id == id }) {
                    items[index].isSelected.toggle()
                }
                return .stylistFocuses(items)
            }
        }
    }

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case subtitle
        case navigationTitle
        case options
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(QuizType.self, forKey: .type)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        self.navigationTitle = try container.decode(String.self, forKey: .navigationTitle)

        switch type {
        case .favoriteColor:
            let decodedItems = try container.decode([FavoriteColorData].self, forKey: .options)
            self.options = .favoriteColors(decodedItems)
        case .stylePreference:
            let decodedItems = try container.decode([StylePreferencesData].self, forKey: .options)
            self.options = .stylePreferences(decodedItems)
        case .stylistFocus:
            let decodedItems = try container.decode([StylistFocusQuizData].self, forKey: .options)
            self.options = .stylistFocuses(decodedItems)
        }
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(navigationTitle, forKey: .navigationTitle)
        
        switch options {
        case .favoriteColors(let items):
            try container.encode(items, forKey: .options)
        case .stylePreferences(let items):
            try container.encode(items, forKey: .options)
        case .stylistFocuses(let items):
            try container.encode(items, forKey: .options)
        }
    }
}
