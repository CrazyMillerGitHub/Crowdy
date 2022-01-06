//
//  ShareViewController.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 20.12.2021.
//

import UIKit
import DesignSystem
import Combine

/// ViewController для экрана шаринга данных
final public class ShareViewController: UIViewController {

	private let presenter: ShareViewPresenterProtocol
	private lazy var cancellable = Set<AnyCancellable>()

	private struct Constant {
		static let qrCodeSize: CGFloat = 180
	}

	private lazy var shareButton: UIButton = {
		let button = UIButton()
		button.setTitle("Печать", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.backgroundColor = Color.darkSpace.uiColor
		button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
		button.layer.cornerRadius = 15
		button.layer.masksToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()

	private lazy var qrCodeImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.layer.cornerRadius = 10
		imageView.layer.masksToBounds = true
		imageView.backgroundColor = .red
		return imageView
	}()

	private lazy var congratulationLabel: UILabel = {
		let label = UILabel()
		let attributedText = NSMutableAttributedString(string: "Почти готово 🎇,\nдавай расскажем о идее")
		let range = NSRange(location: 23, length: 9)
		let textRange = NSRange(location: 0, length: attributedText.string.count + 1)
		let font = UIFont.systemFont(ofSize: 25, weight: .medium)
		attributedText.addAttribute(.foregroundColor, value: Color.darkSpace.uiColor, range: textRange)
		attributedText.addAttribute(.font, value: font, range: textRange)
		attributedText.addAttribute(.foregroundColor, value: Color.blue.uiColor, range: range)
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		label.attributedText = attributedText
		return label
	}()

	public init(with presenter: ShareViewPresenterProtocol) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		assertionFailure("init(coder:) has not been implemented")
		return nil
	}

	public override func loadView() {
		super.loadView()
		view.backgroundColor = .white
	}

	public override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(shareButton)
		view.addSubview(congratulationLabel)
		view.addSubview(qrCodeImageView)

		NSLayoutConstraint.activate([
			congratulationLabel.bottomAnchor.constraint(equalTo: qrCodeImageView.topAnchor, constant: -80),
			congratulationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
			
			qrCodeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			qrCodeImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			qrCodeImageView.heightAnchor.constraint(equalToConstant: Constant.qrCodeSize),
			qrCodeImageView.widthAnchor.constraint(equalToConstant: Constant.qrCodeSize),
			
			shareButton.centerXAnchor.constraint(equalTo: qrCodeImageView.centerXAnchor),
			shareButton.topAnchor.constraint(equalTo: qrCodeImageView.bottomAnchor, constant: 30),
			shareButton.heightAnchor.constraint(equalToConstant: 46),
			shareButton.widthAnchor.constraint(equalTo: qrCodeImageView.widthAnchor)
		])
	}

	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindEvents()
	}

	private func bindEvents() {
		presenter.output
			.receive(on: DispatchQueue.main)
			.sink { event in
				switch event {
				case .didLoad(let image):
					print(image)
				}
			}
			.store(in: &cancellable)
	}
}
