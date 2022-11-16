//
//  HomeBoardFactory.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit

enum HomeFactory: ModuleFactory {
	static func createModule() -> HomeController {
		let viewControler = HomeController()
		let module = ModuleBuilder(with: viewControler)
			.tabBarItemSystemImage("house")
			.title("Информация")
			.build()

		return module
	}
}
