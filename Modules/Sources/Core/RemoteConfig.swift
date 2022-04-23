//
//  RemoteConfig.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import Foundation

public protocol RemoteConfigProtocol {

    var isUserAuthentificated: Bool { get }

    var appVersion: String { get }

    var baseURL: URL { get }
}

/// Конифиг для работы с фичтоглами в модулях
public final class RemoteConfig: RemoteConfigProtocol {

    private unowned let storage: StorageProtocol

    public init(storage: StorageProtocol) {
        self.storage = storage
    }

    public var isUserAuthentificated: Bool {
        true
//        storage.loadValue(for: #function) ?? false
    }

    public var appVersion: String {
        Bundle.main.appVersionLong
    }

    public var baseURL: URL {
        URL(string: "http:localhost")!
    }
}
