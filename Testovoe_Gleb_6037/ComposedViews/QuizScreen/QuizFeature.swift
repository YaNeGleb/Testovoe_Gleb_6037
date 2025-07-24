//
//  QuizFeature.swift
//  Testovoe_Gleb_6037
//
//  Created by Gleb Zabroda on 20.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct QuizFeature {
    @ObservableState
    struct State: Equatable {
        var quizData: QuizItem
        let isFirstQuiz: Bool
    }
    
    enum Action: BindableAction {
        case dismiss
        case binding(_ action: BindingAction<State>)
        case delegate(Delegate)
        case toggleColorSelection(id: UUID)
        enum Delegate {
            case continueButtonTapped
        }
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .toggleColorSelection(id):
                state.quizData.options = state.quizData.options.toggleItem(at: id)
                return .none
                
            case .delegate(let delegateAction):
                switch delegateAction {
                case .continueButtonTapped:
                    return .none
                }
            case .dismiss:
                return .run { _ in
                    await self.dismiss()
                }
            case .binding(_):
                return .none
            }
        }
    }
}

