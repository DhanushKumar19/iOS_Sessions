//
//  ContentView.swift
//  TCA_Demo_part1
//
//  Created by Dhanushkumar Kanagaraj on 19/09/22.
//

import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(spacing: 50) {
                HStack(spacing: 20) {
                    Button("−") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.title)
                    
                    Text("\(viewStore.count)")
                        .font(.title)
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }
                    .font(.title)
                }
                
                Button("Number fact") { viewStore.send(.numberFactButtonTapped) }
                    .font(.title)
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(store: Store(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                numberFact: { number in
                    let (data, _) = try await URLSession.shared
                        .data(from: .init(string: "http://numbersapi.com/\(number)")!)
                    return String(decoding: data, as: UTF8.self)
                }
            )
        ))
    }
}
