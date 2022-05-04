//
//  InfoSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import DesignSystem
import SwiftUI

struct InfoSection: View {

    @Binding
    private var detail: FundDetail

    init(detail: Binding<FundDetail>) {
        self._detail = detail
    }

    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 30)
                .foregroundColor(TokenName.critical.color)
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(TokenName.brand.color)
                .frame(width: 100, height: 30)
            HStack(alignment: .center) {
                Spacer()
                Text("\(detail.progress.remainAmount.value) / \(detail.progress.originalAmount.value)")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .listRowSeparator(.hidden)
    }
}

#endif
