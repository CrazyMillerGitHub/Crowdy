//
//  CancelView.swift
//  
//
//  Created by Mikhail Borisov on 20.04.2022.
//

#if !APPCLIP

import SwiftUI
import ComposableArchitecture
import Core
import DesignSystem

public struct CancelFundView: View {

    private let store: Store<CancelFundState, CancelFundAction>

    public init(store: Store<CancelFundState, CancelFundAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            BottomSheet {
                VStack(alignment: .leading, spacing: 20) {
                    Slider()
                    Text("Внимание")
                        .font(.title2)
                        .bold()
                    Text("Что-то плохое произойдет, все деньги вернуться и тд и тп")
                        .font(.body)
                        .opacity(0.7)
                    Button("Подтвердить отмену") {
                        viewStore.send(.confirmCancellingOrder)
                    }
                    .padding(.vertical)
                    .buttonStyle(BrandButtonStyle(color: .critical))
                }
            }
        }
    }
}

public let cancelFundReducer = Reducer<CancelFundState, CancelFundAction, SystemEnvironment<CancelFundEnvironment>> { _, _, _ in
    return .none
}

#endif
