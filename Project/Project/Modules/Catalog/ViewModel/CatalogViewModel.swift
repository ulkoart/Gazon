//
//  ViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 22.08.2022.
//

import Foundation
import Combine

protocol CatalogViewModel {
	var productsPublisher: Published<[Product]>.Publisher { get }
	var isLoadingPublisher: Published<Bool>.Publisher { get }
	var productsCount: Int { get }

	func retrieveData()
}

final class CatalogViewModelImpl {
	let provider: ApiServiceProvider<ProductsService>

	@Published private var products: [Product] = []
	@Published private var isLoading: Bool = false

	// TODO: - заменить на DI
	init(provider: ApiServiceProvider<ProductsService> = ApiServiceProvider<ProductsService>()) {
		self.provider = provider
	}
}

extension CatalogViewModelImpl: CatalogViewModel {


	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
	var productsPublisher: Published<[Product]>.Publisher { $products }
	var productsCount: Int { products.count }

	func retrieveData() {
		self.isLoading = true
	
		provider.load(service: .products, decodeType: [Product].self) { [weak self] result in
			switch result {
			case let .success(products):
				self?.products = products
				self?.isLoading = false
			case let .failure(error):
				fatalError("Нужно обрабатывать ошибки сети! \(error)")
			}
		}
	}
}
