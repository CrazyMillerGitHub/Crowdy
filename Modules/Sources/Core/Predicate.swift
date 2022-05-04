//
//  Predicate.swift
//  
//
//  Created by Mikhail Borisov on 03.05.2022.
//

import Foundation

public enum Predicate {

    case password
    case email

    public func evaluate(_ value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", rexExp)
        return predicate.evaluate(with: value)
    }

    private var rexExp: String {
        switch self {
        case .password:
            return "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        }
    }
}
