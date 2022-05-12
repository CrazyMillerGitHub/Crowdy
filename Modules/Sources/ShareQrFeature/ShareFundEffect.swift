//
//  File.swift
//  
//
//  Created by Mikhail Borisov on 06.05.2022.
//

import Foundation
import ComposableArchitecture
import Core

public func dummyGetFundURLRequest() -> Effect<String, APIError> {
    return Effect(value: "https:crowdyapp.ru/api/fund/1231")
}
