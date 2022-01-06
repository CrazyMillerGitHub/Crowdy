//
//  ShareViewPresenter.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import UIKit
import Combine

final public class ShareViewPresenter: ShareViewPresenterProtocol {

	private let model: ShareViewModel
	public private(set) lazy var input: PassthroughSubject<ShareViewPresenterInput, Never> = .init()
	public private(set) lazy var output: PassthroughSubject<ShareViewPresenterOutput, Never> = .init()
	private weak var viewController: ShareViewControllerProtocol?
	private lazy var cancellable = Set<AnyCancellable>()

	public init(model: ShareViewModel) {
		self.model = model
		bindEvents()
	}


	public func attach(_ viewController: ShareViewControllerProtocol) {
		self.viewController = viewController
	}

	private func bindEvents() {
		input
			.sink { event in
				switch event {
				case .viewDidLoad:
					print(">>>")
				case .viewWillDismiss:
					print(">>>>")
				}
			}
			.store(in: &cancellable)
	}

	private func loadQrCodeImage() {
//		let image = tools.qrCodeFacade.generateQrCode(content: model.content, builder: nil)
//		output.send(.didLoad(image: UIImage()))
	}
}
