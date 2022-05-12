//
//  InfoSection.swift
//  
//
//  Created by Mikhail Borisov on 13.03.2022.
//

#if !APPCLIP

import DesignSystem
import SwiftUI
import Core

struct InfoSection: View {

    @Binding
    private var detail: FundDetail

    init(detail: Binding<FundDetail>) {
        self._detail = detail
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 30)
                    .foregroundColor(TokenName.critical.color)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(TokenName.brand.color)
                    .frame(width: completedWidth(detail.progress, proxy: proxy), height: 30)
                HStack(alignment: .center) {
                    Spacer()
                    Text(formattedString(detail.progress))
                        .font(.caption2)
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
        .listRowSeparator(.hidden)
    }

    private func completedWidth(_ progress: Progress?, proxy: GeometryProxy) -> CGFloat {
        guard let progress = progress else {
            return proxy.size.width
        }
        let ratio = (progress.originalAmount.amount - progress.remainAmount.amount) / progress.originalAmount.amount
        return proxy.size.width * ratio.doubleValue
    }

    private func formattedString(_ progress: Progress?) -> String {
        guard let progress = progress else {
            return StringFactory.Details.withoutRestrictions.localizableString
        }
        return "\(progress.remainAmount.value) / \(progress.originalAmount.value)"
    }
}

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}

#endif
