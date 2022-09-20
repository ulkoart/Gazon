//
//  SceneDelegate.swift
//  Project
//
//  Created by user on 11.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	var appCoordinator: AppCoordinator?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions) {
			guard
				let windowScene = (scene as? UIWindowScene)
			else { return }

			window = UIWindow(windowScene: windowScene)
			let navigationController = UINavigationController()
			window?.rootViewController = navigationController
			window?.makeKeyAndVisible()
			appCoordinator = AppCoordinator(navigationController: navigationController)
			appCoordinator?.start()
		}

	func sceneDidDisconnect(_ scene: UIScene) {}

	func sceneDidBecomeActive(_ scene: UIScene) {}

	func sceneWillResignActive(_ scene: UIScene) {}

	func sceneWillEnterForeground(_ scene: UIScene) {}

	func sceneDidEnterBackground(_ scene: UIScene) {}
}
