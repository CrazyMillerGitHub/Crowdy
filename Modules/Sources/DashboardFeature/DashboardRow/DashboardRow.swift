//
//  DashboardRow.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

#if !APPCLIP

import Foundation
import SwiftUI
import DesignSystem
import ComposableArchitecture
import Core
import Kingfisher

struct DashboardRow: View {

    private let viewStore: ViewStore<DashboardState, DashboardAction>
    private let fund: Fund
    @Environment(\.colorScheme) var colorScheme

    init(viewStore: ViewStore<DashboardState, DashboardAction>, fund: Fund) {
        self.viewStore = viewStore
        self.fund = fund
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(TokenName.background2.color)
            .overlay {
                HStack(spacing: 10) {
                    KFImage(URL(string: "apple.com")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(fund.title)
                            .font(.footnote)
                            .bold()
                        Text(style(for: fund.status))
                            .foregroundColor(TokenName.accept.color)
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

    func style(for number: Int16) -> String {
        return "В обработке"
    }
}

#endif
