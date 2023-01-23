//
//  ModuleBuilder.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit

final class ModuleBuilder<T> where T: UIViewController {
    private var controller: T

    init(with controller: T) {
        self.controller = controller
    }

    func tabBarItemSystemImage(_ systemName: String) -> Self {
        controller.tabBarItem.image = UIImage(systemName: systemName)
        return self
    }

    func tabBarItemTitle(_ title: String) -> Self {
        controller.tabBarItem.title = title
        return self
    }

    func title(_ title: String) -> Self {
        controller.navigationItem.title = title
        return self
    }

    func build() -> T {
        return controller
    }
}
