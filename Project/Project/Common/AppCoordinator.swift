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
	var childCoordinators: [Coordinator] = []

	var featureToggleFacade: FeatureToggleFacade?
	var localFeatureToggle: FeatureToggleProtocol?
	var remoteFeatureToggle: FeatureToggleProtocol?

	init (navigationController: UINavigationController) {
		self.navigationController = navigationController
		navigationController.setNavigationBarHidden(true, animated: false)
	}

	func start() {
		let previewViewController = SplashFactory.createModule()
		navigationController.viewControllers = [previewViewController]
		loadConfiguration()
	}

	private func loadConfiguration() {

		// MARK: - ServiceLocator service registration
		let remoteFeatureToggleServiceApi = ApiServiceProvider<RemoteFeatureToggleService>()
		ServiceLocator.shared.register(service: remoteFeatureToggleServiceApi)

		// MARK: - FeatureToggle configuration
		let dispatchGroup = DispatchGroup()

		let localFeatureToggleProvider = LocalFeatureToggleProvider()
		localFeatureToggle = LocalFeatureToggle(provider: localFeatureToggleProvider)

		let remoteFeatureToggleProvider = RemoteFeatureToggleProvider()

		dispatchGroup.enter()
		remoteFeatureToggle = RemoteFeatureToggle(provider: remoteFeatureToggleProvider) {
			dispatchGroup.leave()
		}

		/// Срабатывает при установленном timedOut
		let waitResult = dispatchGroup.wait(timeout: .now() + 10)
		if case .timedOut = waitResult {
			Log.warning("⏳ - Долгое ожидание dispatchGroup", shouldLogContext: true)
		}

		dispatchGroup.notify(queue: .main) { [weak self] in
			guard
				let localFeatureToggle = self?.localFeatureToggle,
				let remoteFeatureToggle = self?.remoteFeatureToggle
			else { return }
			self?.featureToggleFacade = FeatureToggleFacade(
				localFeatureToggle: localFeatureToggle,
				remoteFeatureToggle: remoteFeatureToggle
			)
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

/// Тут загружать сначала локальный фиче-тогл, потом сетевой фиче-тогл
/// и инициализировать FeatureToggleFacade уже готовыми данными в notify
///
/// Разделить local и remote FeatureToggle, возможно оставить общий протокол isEnabled
/// в дальнейшем все это нужно вынести в отдельную сущность тк для AppCoordinator это лишнее
