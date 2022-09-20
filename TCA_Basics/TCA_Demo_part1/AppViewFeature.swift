//
//  AppViewFeature.swift
//  TCA_Demo_part1
//
//  Created by Dhanushkumar Kanagaraj on 19/09/22.
//

import ComposableArchitecture
import Foundation

struct AppState: Equatable {
    var count = 0
    var numberFactAlert: String?
}

enum AppAction: Equatable {
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    case factAlertDismissed
    case numberFactResponse(TaskResult<String>)
}

struct AppEnvironment {
    var numberFact: (Int) async throws -> String
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
        case .factAlertDismissed:
            state.numberFactAlert = nil
            return .none
            
        case .decrementButtonTapped:
            state.count -= 1
            return .none
            
        case .incrementButtonTapped:
            state.count += 1
            return .none
            
        case .numberFactButtonTapped:
            return .task {[count = state.count] in
                await .numberFactResponse(TaskResult {try await environment.numberFact(count) })
            }
            
        case let .numberFactResponse(.success(fact)):
            state.numberFactAlert = fact
            return .none
            
        case .numberFactResponse(.failure):
            state.numberFactAlert = "Could not load a number fact :("
            return .none
    }
}.debug()
