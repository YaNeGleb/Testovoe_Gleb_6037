//
//  FavoriteColorsGridView.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct FavoriteColorsGridView: View {
    let colors: [FavoriteColorData]
    let onSelect: (UUID) -> Void

    private let grid = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: grid, spacing: 12) {
            ForEach(colors) { color in
                Button {
                    onSelect(color.id)
                } label: {
                    QuizFavouriteColorCell(colorData: color)
                }
            }
        }
        .padding(.top, 24)
    }
}

struct QuizFavouriteColorCell: View {
    let colorData: FavoriteColorData
    
    var body: some View {
        VStack(spacing: 8) {
            Rectangle()
                .fill(colorData.color)
                .frame(width: 32, height: 32)
                .padding(.top, 12.5)
            
            Text(colorData.name.uppercased())
                .font(.customFont(font: .poppins,
                                  style: colorData.isSelected ? .medium : .light,
                                  size: 13))
                .foregroundStyle(.accent)
                .padding(.bottom, 8)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topTrailing) {
            CheckmarkButton(isSelected: colorData.isSelected, size: 14)
                .padding(.top, 8)
                .padding(.trailing, 8.5)
        }
        .overlay(
            Rectangle()
                .stroke(colorData.isSelected ? .black : .stroke, lineWidth: 0.5)
        )
    }
}
