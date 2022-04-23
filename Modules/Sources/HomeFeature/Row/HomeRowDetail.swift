//
//  HomeRowDetail.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import SwiftUI
import Core
import ComposableArchitecture

struct HomeRowDetail: View {

    private let fund: FundDTO

    var collectedTextValue: String {
        String(
            format: "%@ %.0f%%",
            StringFactory.HomeRow.progress.localizableString,
            fund.amountPrecentage * 100
        )
    }

    var participantsValue: String {
        "\(StringFactory.HomeRow.participants.localizableString) \(fund.participants.formatNumber())"
    }

    var expirationValue: String {
        guard let expirationDate = fund.expirationDate else {
            return StringFactory.HomeRow.without.localizableString
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM DD yyyy"
        return formatter.string(from: .init(timeIntervalSince1970: expirationDate))
    }

    init(fund: FundDTO) {
        self.fund = fund
    }

    var body: some View {
        let values = [collectedTextValue, participantsValue, expirationValue]
        return HStack {
            ForEach(values, id: \.self) { value in
                Text(value)
                    .font(.body)
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
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

#endif
