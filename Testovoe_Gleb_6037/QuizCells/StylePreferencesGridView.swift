//
//  StylePreferencesGridView.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import NukeUI

struct StylePreferencesGridView: View {
    let styles: [StylePreferencesData]
    let onSelect: (UUID) -> Void

    private let grid = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: grid, spacing: 12) {
            ForEach(styles) { style in
                Button {
                    onSelect(style.id)
                } label: {
                    QuizStylePreferenceCell(style: style)
                }
            }
        }
        .padding(.top, 24)
    }
}

struct QuizStylePreferenceCell: View {
    let style: StylePreferencesData
    
    var body: some View {
        VStack(spacing: 4) {
            LazyImage(source: style.imageURL) { state in
                if let image = state.image {
                    image
                } else {
                    ProgressView()
                }
            }
            .frame(width: 108, height: 122)
            
            Text(style.title.uppercased())
                .font(.customFont(font: .poppins,
                                  style: style.isSelected ? .medium : .light,
                                  size: 13))
                .foregroundStyle(.accent)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .overlay(
            Rectangle()
                .stroke(style.isSelected ? .black : .stroke, lineWidth: 0.5)
        )
        .overlay(alignment: .topTrailing) {
            CheckmarkButton(isSelected: style.isSelected)
                .padding(8)
        }
    }
}
