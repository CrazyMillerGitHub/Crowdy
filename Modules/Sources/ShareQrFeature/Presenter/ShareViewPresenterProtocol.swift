//
//  ShareViewPresenterProtocol.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import Combine

public protocol ShareViewPresenterProtocol {

	var input: PassthroughSubject<ShareViewPresenterInput, Never> { get }

	var output: PassthroughSubject<ShareViewPresenterOutput, Never> { get }
}
