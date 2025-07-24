//
//  CheckmarkButton.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 20.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//


import SwiftUI

struct CheckmarkButton: View {
    let isSelected: Bool
    let size: CGFloat

    init(isSelected: Bool, size: CGFloat = 20) {
        self.isSelected = isSelected
        self.size = size
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(isSelected ? Color.black : Color.clear)
                .overlay(
                    Rectangle()
                        .stroke(isSelected ? Color.black : Color.stroke, lineWidth: 0.5)
                )
                .frame(width: size, height: size)

            if isSelected {
                Image("ic_checkmark")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    CheckmarkButton(isSelected: true)
}
