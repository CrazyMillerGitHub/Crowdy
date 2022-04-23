//
//  ShareView.swift
//  
//
//  Created by Mikhail Borisov on 17.04.2022.
//

import SwiftUI
import Core
import ComposableArchitecture
import DesignSystem

#if !APPCLIP

public struct ShareState: Equatable {

    let url: URL

    public static var initialState = Self(url: .init(string: "apple.com")!)

    public init(url: URL) {
        self.url = url
    }
}

public enum ShareAction {}

public struct ShareEnvironment {

    public init() {}
}

public let shareReducer = Reducer<ShareState, ShareAction, SystemEnvironment<ShareEnvironment>> { _, _, _ in
    return .none
}

public struct ShareView: View {

    private let store: Store<ShareState, ShareAction>

    public init(store: Store<ShareState, ShareAction>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            ActivityView([viewStore.url])
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIActivityViewController

    private let elements: [Any]

    init(_ elements: [Any]) {
        self.elements = elements
    }

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return .init(activityItems: elements, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#endif
