//
//  HomeViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import Foundation
import Combine

protocol HomeViewModel {
	var itemsPublisher: Published<[Int]>.Publisher { get }
	var isLoadingPublisher: Published<Bool>.Publisher { get }
	var itemsCount: Int { get }

	func retrieveData()
}

final class HomeViewModelImpl: ObservableObject {
	@Published var items: [Int] = []
	@Published var isLoading: Bool = false
}

extension HomeViewModelImpl: HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading}
	var itemsPublisher: Published<[Int]>.Publisher { $items }

	var itemsCount: Int { items.count }

	func retrieveData() {
		isLoading = true
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			self?.items = [1,2,3,4,5,6,7,8,9]
			self?.isLoading = false
		}
	}
}
