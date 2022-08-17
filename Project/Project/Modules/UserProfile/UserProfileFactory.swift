//
//  UserProfileFactory.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import UIKit

enum UserProfileFactory: ModuleFactory {
	static func createModule() -> UIViewController {
		let viewController = UserProfileController()
		viewController.tabBarItem.image = UIImage(systemName: "person")
		viewController.tabBarItem.title = .none
		viewController.navigationItem.title = "Профиль"
		return viewController
	}
}

