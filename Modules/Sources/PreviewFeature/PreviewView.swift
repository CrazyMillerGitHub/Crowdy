//
//  PreviewView.swift
//  
//
//  Created by Mikhail Borisov on 19.03.2022.
//

#if !APPCLIP

import Foundation
import SwiftUI
import ComposableArchitecture
import Kingfisher
import Core

public struct PreviewState: Equatable {

    let url: URL

    public let id = UUID()

    public init(url: URL) {
        self.url = url
    }
}

public enum PreviewAction {
    case closeButtonTapped
}

public struct PreviewEnvironment {

    public init() {}
}

public typealias PreviewReducer = Reducer<
    PreviewState,
    PreviewAction,
    SystemEnvironment<PreviewEnvironment>
>

public let previewReducer = PreviewReducer { state, action, environment in
    return .none
}

public struct PreviewView: View {

    private let store: Store<PreviewState, PreviewAction>

    public init(store: Store<PreviewState, PreviewAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.white.opacity(0.8))
                            .font(.system(.title))
                            .onTapGesture {
                                viewStore.send(.closeButtonTapped)
                            }
                            .padding()
                    }
                    Spacer()
                }.background(Color.black)
                KFImage(viewStore.url)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

#endif

#if DEBUG
public struct PreviewView_Preview: PreviewProvider {

    public static var previews: some View {
        PreviewView(
            store: .init(
                initialState: .init(url: .init(fileReferenceLiteralResourceName: "placeholder")),
                reducer: previewReducer,
                environment: .dev(
                    environment: PreviewEnvironment()
                )
            )
        )
    }
}
#endif
