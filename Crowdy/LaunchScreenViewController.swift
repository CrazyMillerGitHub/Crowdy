//
//  LaunchScreenViewController.swift
//  Crowdy
//
//  Created by Mikhail Borisov on 03.04.2022.
//

import UIKit
import CoreData

final class LaunchScreenViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Crowdy - сборы \nс человечским лицом"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: view.widthAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
