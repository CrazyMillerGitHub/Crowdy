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

    init(fund: Fund) {
        self.fund = fund
    }

    @State private var infos: (Fund) -> [String] = { store in
        return [
            String(
                format: "%@ %.0f%%",
                StringFactory.HomeRow.progress.localizableString,
                67
//                store.amountPrecentage * 100
            ),
            "\(StringFactory.HomeRow.participants.localizableString) \(10)",
            "\(StringFactory.HomeRow.expireOn.localizableString) 10.11.22"
        ]
    }

    var body: some View {
        
        HStack {
//            ForEach(0..<3) { idx in
//                Text(infos(self.fund)[idx])
//                    .font(.footnote)
//                    .minimumScaleFactor(0.01)
//                    .lineLimit(1)
//                    .redacted(reason: viewStore.state.isLoaded ? [] : .placeholder )
//                    .shimmering(active: !viewStore.state.isLoaded)
//            }
        }
        .frame(height: 20)
    }
}
