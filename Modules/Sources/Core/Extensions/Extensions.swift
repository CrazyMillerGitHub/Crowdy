//
//  Extensions.swift
//  
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import UIKit

public extension RawRepresentable where RawValue == String {
	var localizableString: String { NSLocalizedString(rawValue, bundle: Bundle.main, comment: "") }
}

extension UIViewController {

	open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		super.motionEnded(motion, with: event)
		#if DEBUG
		guard motion == .motionShake else { return }
		print(">>> ")
		#endif
	}
}
