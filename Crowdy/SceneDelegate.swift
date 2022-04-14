//
//  SceneDelegate.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import UIKit
import AppFeature
import SwiftUI

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(
		_ scene: UIScene, willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootView = RootView(
            store: .init(
                initialState: .initialState,
                reducer: mainTabCoordinatorReducer,
                environment: .init()
            )
        )
        window.tintColor = .init(red: 72/256, green: 40/256, blue: 214/256, alpha: 1.0)
        window.rootViewController = UIHostingController(rootView: rootView)
        self.window = window
        
        window.makeKeyAndVisible()
    }

}
