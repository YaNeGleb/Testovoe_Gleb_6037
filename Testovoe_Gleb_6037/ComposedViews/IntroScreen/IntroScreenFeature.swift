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
    
    @ObservableState
    struct State: Equatable {
        var quizItems: [QuizItem] = []
        var isLoading = false
    }
    
    enum Action: BindableAction {
        case binding(_ action: BindingAction<State>)
        case onAppear
        case dataFetching(DataFetching)
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
            case .binding(_):
                return .none
            }
        }
    }
}

