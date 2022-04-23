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
    private let fund: FundDTO
    @Environment(\.colorScheme) var colorScheme

    init(viewStore: ViewStore<DashboardState, DashboardAction>, fund: FundDTO) {
        self.viewStore = viewStore
        self.fund = fund
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(colorScheme == .dark ? Color.darkContent.color : Color.white)
            .overlay {
                HStack(spacing: 10) {
                    KFImage(fund.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 90, height: 90)
                        .cornerRadius(10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(fund.title)
                            .font(.footnote)
                            .bold()
                        Text(fund.status.localizableString)
                            .foregroundColor(Color.accept.color)
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

#endif
