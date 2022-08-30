//
//  AppCoordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

final class PreviewViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(white: 0.95, alpha: 1)
	}

	deinit {
		print("\(Self.self) - \(#function)")
	}
}

protocol AppFlow {
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
		let previewViewController = PreviewViewController()
		navigationController.viewControllers = [previewViewController]
		loadConfiguration()
    }

	private func loadConfiguration() {
		let dispatchGroup = DispatchGroup()

		dispatchGroup.enter()
		featureToggleFacade = FeatureToggleFacade() {
			dispatchGroup.leave()
		}

		dispatchGroup.notify(queue: .main) { [weak self] in
			self?.coordinateToMainFlow()
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
