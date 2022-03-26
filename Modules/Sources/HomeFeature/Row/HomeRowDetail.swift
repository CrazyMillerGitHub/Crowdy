//
//  HomeRowDetail.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

import SwiftUI
import Core
import ComposableArchitecture

struct HomeRowDetail: View {

    private let fund: Fund

    var collectedTextValue: String {
        String(
            format: "%@ %.0f%%",
            StringFactory.HomeRow.progress.localizableString,
            fund.amountPrecentage
        )
    }

    var participantsValue: String {
        "\(StringFactory.HomeRow.participants.localizableString) \(fund.participants)"
    }

    var expirationValue: String {
        guard let expirationDate = fund.expirationDate else {
            return StringFactory.HomeRow.without.localizableString
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM DD yyyy"
        return formatter.string(from: .init(timeIntervalSince1970: expirationDate))
    }

    init(fund: Fund) {
        self.fund = fund
    }

    var body: some View {
        var values = [collectedTextValue, participantsValue, expirationValue]
        return HStack {
            ForEach(values, id: \.self) { value in
                Text(value)
            }
        }
        .frame(height: 20)
    }
}

private struct HomeDetailInfo<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .font(.caption)
            .minimumScaleFactor(0.01)
            .lineLimit(1)
    }
}
