//
//  ServiceLocating.swift
//  Project
//
//  Created by Улько Артем Викторович on 30.08.2022.
//

import Foundation

protocol ServiceLocating {
	func resolve<T>() -> T?
	func register<T>(service: T)
}
