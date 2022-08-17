//
//  HomeInfoController.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import UIKit

class HomeInfoController: UIViewController {

    var coordinator: HomeInfoFlow?

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Закрыть", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    deinit {
        print("deinit - HomeInfoController")
    }

    private func setup() {
        view.backgroundColor = .systemGray2
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 200),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            closeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    @objc func closeButtonTapped(_ sender: UIButton) {
         coordinator?.closeInfo()
    }
}
