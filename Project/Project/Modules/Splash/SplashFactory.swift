//
//  SplashFactory.swift
//  Project
//
//  Created by Улько Артем Викторович on 20.09.2022.
//

import Foundation

enum SplashFactory: ModuleFactory {
	static func createModule() -> SplashController {
		let viewControler = SplashController()
		let module = ModuleBuilder(with: viewControler).build()
		return module
	}
}
