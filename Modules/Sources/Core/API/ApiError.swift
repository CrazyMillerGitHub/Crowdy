//
//  ApiError.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 05.01.2022.
//

#if !APPCLIP

import Foundation

public enum APIError: Error {
	case downloadError
	case decodingError
	case urlError
}

#endif
