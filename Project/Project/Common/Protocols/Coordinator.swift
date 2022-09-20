//
//  Coordinator.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator?) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
