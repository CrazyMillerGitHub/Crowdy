//
//  Extensions.swift
//  
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import UIKit
import SwiftUI

public extension RawRepresentable where RawValue == String {
	var localizableString: String { NSLocalizedString(rawValue, bundle: Bundle.main, comment: "") }
}

extension UIViewController {

	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		#if DEBUG
		guard motion == .motionShake else {
            super.motionEnded(motion, with: event)
            return
        }
        let networkViewController = UIHostingController(rootView: NetworkView())
        guard var viewController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController else {
            return
        }
        while let presentedViewController = viewController.presentedViewController {
            viewController = presentedViewController
        }
        viewController.present(networkViewController, animated: true)
		#endif
	}
}
