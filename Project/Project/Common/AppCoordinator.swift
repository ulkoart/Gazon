//
//  AppCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

protocol AppFlow {
	func coordinateToMainFlow()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
		let previewViewController = UIViewController()
		previewViewController.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
		navigationController.viewControllers = [previewViewController]
		loadfeatureToggle()
    }
	
	private func loadfeatureToggle() {
		let featureToggleService = FeatureToggleService.shared
		let provider = RemoteFeatureToggleProvider()
		featureToggleService.fetchFeatureToggles(provider: provider) { [weak self] in
			DispatchQueue.main.async {
				self?.coordinateToMainFlow()
			}
		}
	}
}

extension AppCoordinator: AppFlow {
	func coordinateToMainFlow() {
		let tabBarCoordinator = TabBarCoordinator(navigationController)
		store(coordinator: tabBarCoordinator)
		tabBarCoordinator.start()
	}
}
