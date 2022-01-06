//
//  Font.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import UIKit
import SwiftUI

public enum Font {

	case button

	public var font: SwiftUI.Font {
		switch self {
		case .button:
			return .system(size: 15, weight: .semibold, design: .default)
		}
	}
}
