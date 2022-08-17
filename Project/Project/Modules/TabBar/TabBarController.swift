//
//  TabBarController.swift
//  Project
//
//  Created by user on 15.08.2022.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

		if #available(iOS 15, *) {
			let appearance = UINavigationBarAppearance()
			appearance.configureWithDefaultBackground()
			UINavigationBar.appearance().standardAppearance = appearance
			UINavigationBar.appearance().scrollEdgeAppearance = appearance
		}

		if #available(iOS 15, *) {
			let appearance = UITabBarAppearance()
			appearance.configureWithDefaultBackground()
			UITabBar.appearance().standardAppearance = appearance
			UITabBar.appearance().scrollEdgeAppearance = appearance
		}

		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
