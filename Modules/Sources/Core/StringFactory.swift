//
//  StringFactory.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import Foundation

public enum StringFactory {}

public extension StringFactory {

	enum News: String {
		case `continue`
		case whatsNew
	}

	enum HomeRow: String {
		case participants
		case expireOn
		case progress
	}
}
