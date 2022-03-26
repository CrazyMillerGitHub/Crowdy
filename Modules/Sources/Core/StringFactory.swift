//
//  StringFactory.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

import Foundation

public enum StringFactory {}

// MARK: - Tab
public extension StringFactory {

    enum Tab: String {
        case settings
        case discovery
        case dashboard
    }
}

// MARK: - News
public extension StringFactory {

	enum News: String {
		case `continue`
		case whatsNew
	}
}

// MARK: - HomeRow
public extension StringFactory {

    enum HomeRow: String {
        case participants
        case expireOn
        case progress
        case without
    }
}

// MARK: - AuthFeature
public extension StringFactory {

    enum AuthFeature: String {
        case login
        case password
        case forgotPassword
        case logIn
    }
}

// MARK: - Settings
public extension StringFactory {

    enum Settings: String {
        case logOut
        case welcomeBack
        case spent
        case recentCrowdfundings
    }
}

// MARK: - Details
public extension StringFactory {

    enum Details: String {
        case donate
        case cancel
        case previewImages
        case stage
    }
}

// MARK: - Dashboard
public extension StringFactory {

    enum Dashboard: String {
        case activeFund
        case previousFund
    }
}

// MARK: - Add
public extension StringFactory {

    enum Add: String {
        case createFund
        case publish
        case cancel
        case category
        case fundExpiration
        case without
    }
}
