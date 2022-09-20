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
        button.translatesAutoresizingMaskIntoConstraints = true
        button.sizeToFit()
        button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.navy?.cgColor
		button.setTitleColor(UIColor.navy ?? .black, for: .normal)
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
		Logger.shared.log("🗑 - \(Self.self)")
    }

    private func setup() {
		view.backgroundColor = .almond

		// MARK: - logoImageView
		view.addSubview(logoImageView)

		let rootViewWidth = view.frame.width // TODO: vs frame.size.width
		let rootViewHeight = view.frame.height

		let logoImageViewWidth: CGFloat = 150
		let logoImageViewHeight: CGFloat = 150
		let logoImageViewX = (rootViewWidth / 2) - (logoImageViewWidth / 2)
		let logoImageViewY = (rootViewHeight / 2) - (logoImageViewHeight / 2)

		let logoImageViewFrame: CGRect = .init(
			x: logoImageViewX,
			y: logoImageViewY,
			width: logoImageViewWidth,
			height: logoImageViewHeight
		)
		logoImageView.frame = logoImageViewFrame

		// MARK: - closeButton
		view.addSubview(closeButton)

		let closeButtonWidth: CGFloat = 150
		let closeButtonHeight: CGFloat = 50
		let closeButtonX: CGFloat = logoImageView.frame.minX
		let closeButtonY: CGFloat = logoImageView.frame.maxY + 8.0

        let closeButtonFrame: CGRect = .init(
            x: closeButtonX,
            y: closeButtonY,
            width: closeButtonWidth,
            height: closeButtonHeight
        )

		closeButton.frame = closeButtonFrame
    }

    @objc func closeButtonTapped(_ sender: UIButton) {
         coordinator?.closeInfo()
    }
}
