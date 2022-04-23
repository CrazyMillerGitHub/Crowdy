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

public enum CancelFundAction {
    case confirmCancellingOrder
}

public struct CancelFundState: Equatable {

    public init() {}
}

public struct CancelFundEnvironment {

    public init() {}
}

public struct CancelFundView: View {

    private let store: Store<CancelFundState, CancelFundAction>

    public init(store: Store<CancelFundState, CancelFundAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            BottomSheet {
                VStack(alignment: .leading, spacing: 20) {
                    HStack() {
                        Spacer()
                        RoundedRectangle(cornerRadius: 2)
                            .fill(.gray.opacity(0.7))
                            .frame(width: 35, height: 4)
                        Spacer()
                    }
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
                    .buttonStyle(BrandButtonStyle(color: .magnetta))
                }
            }
        }
    }
}

public let cancelFundReducer = Reducer<CancelFundState, CancelFundAction, SystemEnvironment<CancelFundEnvironment>> { _, _, _ in
    return .none
}

#endif
