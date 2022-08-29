//
//  HomeInfoController.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

final class HomeInfoController: UIViewController {

    var coordinator: HomeInfoFlow?

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
		button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

	private let logoImageView: UIImageView = {
		$0.image = UIImage(named: "logo")
		return $0
	}(UIImageView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        print("deinit - HomeInfoController")
    }

    private func setup() {
        view.backgroundColor = .systemBlue

		view.addSubview(logoImageView)
		logoImageView.centerInSuperview()

		view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 200),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
			closeButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 8),
            closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    @objc func closeButtonTapped(_ sender: UIButton) {
         coordinator?.closeInfo()
    }
}
