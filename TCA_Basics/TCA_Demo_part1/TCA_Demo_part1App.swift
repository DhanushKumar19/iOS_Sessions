//
//  TCA_Demo_part1App.swift
//  TCA_Demo_part1
//
//  Created by Dhanushkumar Kanagaraj on 19/09/22.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCA_Demo_part1App: App {
    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(),
                    reducer: appReducer,
                    environment: AppEnvironment(
                        numberFact: { number in
                            let (data, _) = try await URLSession.shared
                                .data(from: .init(string: "http://numbersapi.com/\(number)")!)
                            return String(decoding: data, as: UTF8.self)
                        }
                    )
                )
            )
        }
    }
}
