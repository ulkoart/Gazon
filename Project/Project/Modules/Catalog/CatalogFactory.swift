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
        viewController.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        viewController.tabBarItem.title = .none
        viewController.navigationItem.title = "Каталог"
        return viewController
    }
}
