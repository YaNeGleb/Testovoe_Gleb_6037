//
//  Font + Extensions.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 24.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension Font {
    static func customFont(
        font: CustomFonts,
        style: CustomFontStyle,
        size: CGFloat) -> Font {
            let fontName: String = font.rawValue + style.rawValue
            return Font.custom(fontName, size: size)
        }
}
