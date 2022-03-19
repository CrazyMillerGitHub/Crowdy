//
//  DashboardRow.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct DashboardRow: View {

    private let viewStore: ViewStore<DashboardState, DashboardAction>

    init(viewStore: ViewStore<DashboardState, DashboardAction>) {
        self.viewStore = viewStore
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay {
                HStack(spacing: 10) {
                    Image("placeholder", bundle: .main)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Крутой стол в каждый дом")
                            .font(.footnote)
                            .bold()
                        Text("Сбор продолжается")
                            .font(.caption)
                    }
                    Spacer()
                }
            }
            .frame(height: 90)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 0)
            .padding([.leading, .trailing])
            .onTapGesture {
                viewStore.send(.selectFund(.init()))
            }
    }
}
