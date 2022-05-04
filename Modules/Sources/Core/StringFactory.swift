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
        case logIn
        case password
        case confirmPassword
        case fullName
        case areYouRegistered
        case register
        case forgotPassword
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

// MARK: - Onboarding
public extension StringFactory {

    enum Onboarding: String {
        case logIn
        case register
    }
}

// MARK: - EditProfile
public extension StringFactory {

    enum EditProfile: String {
        case saveChanges
    }
}

// MARK: - Forget
public extension StringFactory {

    enum Forget: String {
        case passwordReset
        case sendRequest
        case login
    }
}

// MARK: - FundSelection
public extension StringFactory {

    enum FundSelection: String {
        case createFund
        case internalFund
        case internalDescription
        case externalFund
        case externalDescription
    }
}

// MARK: - Alert
public extension StringFactory {

    enum Alert: String {
        case error
        case somethingWentWrong
        case done
        case dataSuccessfullyUpdated
        case ok
    }
}
