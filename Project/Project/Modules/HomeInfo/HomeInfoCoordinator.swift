//
//  HomeInfoCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

protocol HomeInfoFlow {
	func closeInfo()
}

final class HomeInfoCoordinator: Coordinator {
	var childCoordinators: [Coordinator] = []
	let navigationController: UINavigationController
	var isCompleted: (() -> Void)?
	
	init(_ navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let controller = HomeInfoController()
		controller.modalPresentationStyle = .fullScreen
		controller.coordinator = self
		navigationController.present(controller, animated: true, completion: nil)
	}
	
	deinit {
		Log.error("🗑 - \(Self.self)", shouldLogContext: false)
	}
}

extension HomeInfoCoordinator: HomeInfoFlow {
	func closeInfo() {
		navigationController.dismiss(animated: true, completion: nil)
		isCompleted?()
	}
}
