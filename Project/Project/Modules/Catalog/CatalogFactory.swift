//
//  CatalogFactory.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit

enum CatalogFactory: ModuleFactory {
    static func createModule() -> CatalogController {
        let viewController = CatalogController()
		let module = ModuleBuilder(with: viewController)
			.tabBarItemSystemImage("list.bullet.rectangle")
			.title("Каталог")
			.build()
		return module
    }
}
