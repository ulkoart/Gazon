//
//  BaseController.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.10.2022.
//

import UIKit

class BaseController: UIViewController {

	let activityIndicator: UIActivityIndicatorView = {
		$0.style = .large
		$0.startAnimating()
		$0.hidesWhenStopped = true
		return $0
	}(UIActivityIndicatorView())

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(activityIndicator)
		activityIndicator.centerInSuperview()
	}
}
