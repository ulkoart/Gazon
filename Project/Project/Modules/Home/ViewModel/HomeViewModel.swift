//
//  HomeViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import Foundation
import Combine

protocol HomeViewModel {
	var itemsPublisher: Published<[ToDo]>.Publisher { get }
	var isLoadingPublisher: Published<Bool>.Publisher { get }
	var itemsCount: Int { get }

	func retrieveData()
}

final class HomeViewModelImpl: ObservableObject {
	let provider: ApiServiceProvider<JPHService>
	
	@Published private var items: [ToDo] = []
	@Published private var isLoading: Bool = false

	init(provider: ApiServiceProvider<JPHService> = ApiServiceProvider<JPHService>()) {
		self.provider = provider
	}
}

extension HomeViewModelImpl: HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading}
	var itemsPublisher: Published<[ToDo]>.Publisher { $items }
	var itemsCount: Int { items.count }

	func retrieveData() {
		self.isLoading = true

		provider.load(service: .todos, decodeType: [ToDo].self) { [weak self] result in
			switch result {
			case let .success(todos):
				self?.items = todos
				self?.isLoading = false
			case let .failure(error):
				fatalError("Нужно обрабатывать ошибки сети! \(error)")
			}
		}
	}
}
