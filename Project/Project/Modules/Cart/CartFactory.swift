//
//  CartFactory.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import UIKit

enum CartFactory: ModuleFactory {
	static func createModule() -> UIViewController {
		let viewController = CartController()
		viewController.tabBarItem.image = UIImage(systemName: "cart")
		viewController.tabBarItem.title = .none
		viewController.navigationItem.title = "Корзина"
		return viewController
	}
}
