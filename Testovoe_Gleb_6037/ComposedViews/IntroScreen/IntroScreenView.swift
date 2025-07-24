//
//  IntroScreenView.swift
//  Testovoe_Gleb_6037App
//
//  Created by Gleb Zabroda on 20.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct IntroScreenView: View {
    @Perception.Bindable var store: StoreOf<IntroScreenFeature>
    
    var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                ZStack(alignment: .bottom) {
                    Image("introScreenImage")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [.clear, .black, .black]),
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                    
                    VStack(alignment: .leading, spacing: 61) {
                        Spacer()
                        Text("Online Personal\nStyling.\nOutfits for\nEvery Woman.")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .font(.customFont(font: .kaiseiTokumin, style: .medium, size: 32))
                        
                        Button {
                            store.send(.navigation(.goToNextQuiz))
                        } label: {
                            Text("TAKE A QUIZ")
                                .font(.customFont(font: .poppins, style: .regular, size: 14))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13.5)
                                .foregroundColor(.primary)
                                .background(.white)
                        }
                        .padding(.bottom, 62)
                    }
                    .padding(.horizontal, 20)
                }
                .onAppear {
                    store.send(.onAppear)
                }
            } destination: { store in
                switch store.case {
                case let .quizScreen(quizScreenStore):
                    QuizView(store: quizScreenStore)
                }
            }
        }
    }
}

#Preview {
    let store = Store(initialState: IntroScreenFeature.State()) {
        IntroScreenFeature()
            .dependency(\.remoteConfig, RemoteConfigManager.testValue)
    }
    IntroScreenView(store: store)
}
