//
//  HomeViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import Foundation
import Combine

protocol HomeViewModel {
	var itemsPublisher: Published<[Product]>.Publisher { get }
	var isLoadingPublisher: Published<Bool>.Publisher { get }
	var itemsCount: Int { get }

	func retrieveData()
}

final class HomeViewModelImpl: ObservableObject {
	let provider: ApiServiceProvider<ProductsService>

	@Published private var items: [Product] = []
	@Published private var isLoading: Bool = false

	init(provider: ApiServiceProvider<ProductsService> = ApiServiceProvider<ProductsService>()) {
		self.provider = provider
	}
}

extension HomeViewModelImpl: HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading}
	var itemsPublisher: Published<[Product]>.Publisher { $items }
	var itemsCount: Int { items.count }

	func retrieveData() {
		self.isLoading = true

		provider.load(service: .products, decodeType: [Product].self) { [weak self] result in
			switch result {
			case let .success(products):
				self?.items = products
				self?.isLoading = false
			case let .failure(error):
				fatalError("Нужно обрабатывать ошибки сети! \(error)")
			}
		}
	}
}
