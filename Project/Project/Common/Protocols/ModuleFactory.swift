//
//  ModuleFactoryProtocol.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit

/// Протокол создания модуля
protocol ModuleFactory {
    associatedtype ControllerType: UIViewController

    static func createModule() -> ControllerType
}
