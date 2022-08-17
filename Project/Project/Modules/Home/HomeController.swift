//
//  HomeBoardController.swift
//  Project
//
//  Created by user on 12.08.2022.
//

import UIKit

final class HomeController: UIViewController {

    var coordinator: HomeFlow?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let infoButton = UIBarButtonItem(
                    image: UIImage(systemName: "info.circle"), style: .plain,
            target: self, action: #selector(infoButtonTapped))
        navigationItem.rightBarButtonItems = [infoButton]
    }

    @objc private func infoButtonTapped() {
        coordinator?.coordinateToInfo()
    }
}
