//
//  RemoteConfig.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

public protocol RemoteConfigProtocol {

    var isUserAuthentificated: Bool { get }
}

/// Конифиг для работы с фичтоглами в модулях
public final class RemoteConfig: RemoteConfigProtocol {

    private unowned let storage: StorageProtocol

    public init(storage: StorageProtocol) {
        self.storage = storage
    }

    public var isUserAuthentificated: Bool {
        storage.loadValue(for: #function) ?? false
    }
}
