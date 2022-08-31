//
//  AppCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

protocol AppFlow: AnyObject {
	func coordinateToMainFlow()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
	var featureToggleFacade: FeatureToggleFacade?
    var childCoordinators: [Coordinator] = []

    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
		let previewViewController = SplashController()
		navigationController.viewControllers = [previewViewController]
		loadConfiguration()
    }

	private func loadConfiguration() {

		let remoteFeatureToggleServiceApi = ApiServiceProvider<RemoteFeatureToggleService>()
		ServiceLocator.shared.register(service: remoteFeatureToggleServiceApi)

		featureToggleFacade = FeatureToggleFacade { [weak self] in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
