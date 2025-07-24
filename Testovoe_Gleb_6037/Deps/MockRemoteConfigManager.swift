//
//  MockRemoteConfigManager.swift
//  Testovoe_Gleb_6037App
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ComposableArchitecture

class MockRemoteConfigManager: RemoteConfigProtocol {
    func fetchAndActivate() async throws { }
    func fetchJSONData(for key: RemoteConfigManager.Key) -> Data? {
        switch key {
        case .quizRemoteConfig:
            let json = """
            [
              {
                "type": "stylistFocus",
                "title": "What’d you like our stylists to focus on?",
                "subtitle": "We offer services via live-chat mode.",
                "navigationTitle": "Lifestyle & Interests",
                "options": [
                  {
                    "title": "Reinvent wardrobe",
                    "subtitle": "to discover fresh outfit ideas"
                  },
                  {
                    "title": "Define color palette",
                    "subtitle": "to enhance my natural features"
                  },
                  {
                    "title": "Create a seasonal capsule",
                    "subtitle": "to curate effortless and elegant looks"
                  },
                  {
                    "title": "Define my style",
                    "subtitle": "to discover my signature look"
                  },
                  {
                    "title": "Create an outfit for an event",
                    "subtitle": "to own a spotlight wherever you go"
                  }
                ]
              },
              {
                "type": "stylePreference",
                "title": "Which style best represents you?",
                "subtitle": null,
                "navigationTitle": "Style preferences",
                "options": [
                  {
                    "image": "https://i.postimg.cc/ZRYQctnJ/Quiz-girls-images.png",
                    "title": "CASUAL"
                  },
                  {
                    "image": "https://i.postimg.cc/FzV7QSmy/Quiz-girls-images.png",
                    "title": "BOHO"
                  },
                  {
                    "image": "https://i.postimg.cc/90hrSb3X/Quiz-girls-images-1.png",
                    "title": "CLASSY"
                  },
                  {
                    "image": "https://i.postimg.cc/FzV7QSmy/Quiz-girls-images.png",
                    "title": "LADYLIKE"
                  },
                  {
                    "image": "https://i.postimg.cc/d1dh4XxS/Rectangle-4337.png",
                    "title": "URBAN"
                  },
                  {
                    "image": "https://i.postimg.cc/wB2qv2JG/Rectangle-4337.png",
                    "title": "SPORTY"
                  }
                ]
              },
              {
                "type": "favoriteColor",
                "title": "Choose favourite colors",
                "subtitle": null,
                "navigationTitle": "Style preferences",
                "options": [
                  {
                    "name": "Light blue",
                    "hex": "#ABE2FF"
                  },
                  {
                    "name": "Blue",
                    "hex": "#5EA8FF"
                  },
                  {
                    "name": "Indigo",
                    "hex": "#2237A8"
                  },
                  {
                    "name": "Turquoise",
                    "hex": "#69D1ED"
                  },
                  {
                    "name": "Mint",
                    "hex": "#87DBC8"
                  },
                  {
                    "name": "Olive",
                    "hex": "#A8AD49"
                  },
                  {
                    "name": "Green",
                    "hex": "#29AD3E"
                  },
                  {
                    "name": "Emerald",
                    "hex": "#098052"
                  },
                  {
                    "name": "Yellow",
                    "hex": "#EDDD47"
                  },
                  {
                    "name": "Beige",
                    "hex": "#CA9675"
                  },
                  {
                    "name": "Orange",
                    "hex": "#CD6A09"
                  },
                  {
                    "name": "Brown",
                    "hex": "#7F4B03"
                  },
                  {
                    "name": "Pink",
                    "hex": "#FF86B8"
                  },
                  {
                    "name": "Magenta",
                    "hex": "#CF236E"
                  },
                  {
                    "name": "Red",
                    "hex": "#D31E1E"
                  }
                ]
              }
            ]
            """
            return json.data(using: .utf8)
        }
    }
}
