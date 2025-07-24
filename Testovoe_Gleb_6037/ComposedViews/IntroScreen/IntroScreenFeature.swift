//
//  IntroScreenFeature.swift
//  Testovoe_Gleb_6037App
//
//  Created by Gleb Zabroda on 20.07.2025.
//  Copyright © 2025 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct IntroScreenFeature {
    @Reducer
    enum Path {
        case quizScreen(QuizFeature)
    }
    
    @ObservableState
    struct State: Equatable {
        var path = StackState<Path.State>()
        var quizItems: [QuizItem] = []
        var isLoading = false
    }
    
    enum Action: BindableAction {
        case binding(_ action: BindingAction<State>)
        case navigation(Navigation)
        case path(StackAction<Path.State, Path.Action>)
        case onAppear
        case dataFetching(DataFetching)
        enum Navigation {
            case goToNextQuiz
        }
        enum DataFetching {
            case loadQuizData
            case quizDataLoaded([QuizItem])
        }
    }
    
    @Dependency(\.remoteConfig) var remoteConfig
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                var effects: [Effect<Action>] = []
                if state.quizItems.isEmpty {
                    effects.append(.send(.dataFetching(.loadQuizData)))
                }
                return .concatenate(effects)
                
            case .dataFetching(let dataFetchingAction):
                switch dataFetchingAction {
                case .loadQuizData:
                    state.isLoading = true
                    return .run { send in
                        do {
                            guard let jsonData = remoteConfig.fetchJSONData(for: .quizRemoteConfig) else {
                                print("IntroScreenFeature | Failed loadQuizData | No data for key .quizRemoteConfig")
                                await send(.dataFetching(.quizDataLoaded([])))
                                return
                            }
                            let quizItems = try JSONDecoder().decode([QuizItem].self, from: jsonData)
                            await send(.dataFetching(.quizDataLoaded(quizItems)))
                        } catch {
                            print("IntroScreenFeature | Failed loadQuizData | \(error.localizedDescription)")
                            await send(.dataFetching(.quizDataLoaded([])))
                        }
                    }
                case .quizDataLoaded(let quizItems):
                    state.isLoading = false
                    state.quizItems = quizItems
                    return .none
                }
                
            case .navigation(let navigationAction):
                switch navigationAction {
                case .goToNextQuiz:
                    let currentQuizIndex = state.path.ids.count
                    guard currentQuizIndex < state.quizItems.count else {
                        state.path.removeAll()
                        return .none
                    }
                    let nextQuizData = state.quizItems[currentQuizIndex]
                    let isFirstQuiz = currentQuizIndex == 0
                    state.path.append(.quizScreen(QuizFeature.State(quizData: nextQuizData,
                                                                    isFirstQuiz: isFirstQuiz)))
                    return .none
                }
            case let .path(action):
                switch action {
                case .element(id: _, action: .quizScreen(.delegate(.continueButtonTapped))):
                    return .send(.navigation(.goToNextQuiz))
                default:
                    return .none
                }
            case .binding(_):
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
extension IntroScreenFeature.Path.State: Equatable {}

