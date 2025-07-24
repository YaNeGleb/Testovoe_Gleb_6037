//
//  QuizView.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 20.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct QuizView: View {
    let store: StoreOf<QuizFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(store.quizData.title)
                        .font(.customFont(font: .kaiseiTokumin, style: .medium, size: 26))
                        .foregroundStyle(.accent)
                    
                    if let subtitle = store.quizData.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .font(.customFont(font: .poppins, style: .light, size: 14))
                            .foregroundStyle(.accent)
                            .padding(.top, 8)
                    }
                    
                    switch store.quizData.options {
                    case let .favoriteColors(colors):
                        FavoriteColorsGridView(colors: colors, onSelect: { selectedItemId in
                            store.send(.toggleColorSelection(id: selectedItemId))
                        })
                        
                    case let .stylePreferences(styles):
                        StylePreferencesGridView(styles: styles, onSelect: { selectedItemId in
                            store.send(.toggleColorSelection(id: selectedItemId))
                        })
                    case let .stylistFocuses(items):
                        StylistFocusListView(items: items, onSelect: { selectedItemId in
                            store.send(.toggleColorSelection(id: selectedItemId))
                        })
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .overlay(alignment: .bottom) {
                Button {
                    store.send(.delegate(.continueButtonTapped))
                } label: {
                    Text("CONTINUE")
                        .font(.customFont(font: .poppins, style: .regular, size: 14))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13.5)
                        .foregroundStyle(.white)
                        .background(.accent)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 22)
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !store.isFirstQuiz {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            store.send(.dismiss)
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.accent)
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(store.quizData.navigationTitle.uppercased())
                        .font(.customFont(font: .poppins, style: .regular, size: 14))
                        .foregroundStyle(.accent)
                }
            }
        }
    }
}
