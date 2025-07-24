//
//  StylistFocusListView.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 22.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

struct StylistFocusListView: View {
    let items: [StylistFocusQuizData]
    let onSelect: (UUID) -> Void

    var body: some View {
        VStack(spacing: 12) {
            ForEach(items) { item in
                Button {
                    onSelect(item.id)
                } label: {
                    QuizStylistFocusCell(quiz: item)
                }
            }
        }
        .padding(.top, 24)
    }
}

struct QuizStylistFocusCell: View {
    let quiz: StylistFocusQuizData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text(quiz.title.uppercased())
                    .font(.customFont(font: .poppins, style: .medium, size: 13))
                    .foregroundStyle(.accent)
                
                Text(quiz.subtitle)
                    .font(.customFont(font: .poppins, style: .light, size: 14))
                    .foregroundStyle(.accent)
            }
            Spacer()
            CheckmarkButton(isSelected: quiz.isSelected)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
        .overlay(
            Rectangle()
                .stroke(quiz.isSelected ? .black : .stroke, lineWidth: 0.5)
        )
    }
}
