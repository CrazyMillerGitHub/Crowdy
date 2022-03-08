//
//  Storage.swift
//  
//
//  Created by Mikhail Borisov on 08.03.2022.
//

import Foundation

public protocol StorageProtocol: AnyObject {

    /// Загрузить данные
    /// - Returns: значение
    func loadValue(for key: String) -> Bool?
}

public final class Storage: StorageProtocol {

    public func loadValue(for key: String) -> Bool? {
        UserDefaults.standard.bool(forKey: key)
    }
}
