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

public extension Double {

    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self
        let truncated = Double(Int(newDecimal))
        let originalDecimal = truncated / multiplier
        return originalDecimal
    }
}

public extension Int {

    func formatNumber() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000...:
            var formatted = num / 1_000_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)B"
        case 1_000_000...:
            var formatted = num / 1_000_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)M"

        case 1_000...:
            var formatted = num / 1_000
            formatted = formatted.reduceScale(to: 1)
            return "\(sign)\(formatted)K"

        case 0...:
            return "\(self)"

        default:
            return "\(sign)\(self)"
        }
    }
}

extension Bundle {

    public var appName: String { getInfo("CFBundleName")  }
    public var displayName: String {getInfo("CFBundleDisplayName")}
    public var language: String {getInfo("CFBundleDevelopmentRegion")}
    public var identifier: String {getInfo("CFBundleIdentifier")}
    public var copyright: String {getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }

    public var appBuild: String { getInfo("CFBundleVersion") }
    public var appVersionLong: String { getInfo("CFBundleShortVersionString") }

    private func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
