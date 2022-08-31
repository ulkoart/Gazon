//
//  SplashController.swift
//  Project
//
//  Created by Улько Артем Викторович on 31.08.2022.
//

import UIKit

final class SplashController: UIViewController {

	weak var coordinator: AppFlow?

	private let titleLable: UILabel = {
		$0.text = "gazon"
		$0.font = .init(.systemFont(ofSize: 48, weight: .bold))
		$0.textColor = .navy
		return $0
	}(UILabel())

	private let nextColor: [UIColor? : UIColor?] = [
		.navy: .redOrange,
		.redOrange: .mango,
		.mango: .navy
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		startAnimation()
	}

	private func setup() {
		view.backgroundColor = .almond

		view.addSubview(titleLable)
		titleLable.centerInSuperview()
	}

	private func startAnimation() {
		animateTitleLableColor(nextColor.first?.value ?? .navy)
	}

	private func animateTitleLableColor(_ color: UIColor?) {
		UIView.transition(with: titleLable, duration: 0.3, options: .transitionCrossDissolve, animations: {
			self.titleLable.textColor = color
		}) { finished in
			if finished {
				self.animateTitleLableColor(
					self.nextColor[color] ?? color
				)
			}
		}
	}

	deinit {
		print("\(Self.self) - \(#function)")
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}
}
