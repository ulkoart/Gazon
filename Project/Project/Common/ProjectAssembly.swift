//
//  ProjectAssembly.swift
//  Project
//
//  Created by user on 11.08.2022.
//

import UIKit

/// Старт приложения - создание TabBar с модулями
enum AppAssembly {
    case catalog

    /// Точка входа в прилодение
    /// - Parameter modules: набор модулей
    /// - Returns: TabBar с указанными модулями
    static func build(_ modules: [Self]) -> UIViewController {
        let readyModules = modules.map { module -> UIViewController in
            switch module {
            case .catalog:
                return CatalogFactory.createModule()
            }
        }
        return tabBarContainer(readyModules)
    }

    /// Упаковщик контроллера в TabBar
    /// - Parameter controllers: набор контроллеров
    /// - Returns: TabBar
    private static func tabBarContainer(_ controllers: [UIViewController]) -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers
        return tabBarController
    }
}
