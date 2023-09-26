//
//  HomeViewModelMock.swift
//  ProjectTests
//
//  Created by Улько Артем Викторович on 13.09.2022.
//

import Foundation

class HomeViewModelMock: HomeViewModel {
	var code: String?

	var numberOfXLBanners: Int?

	var blocksCount: Int = 0

	var isCallretrieveData = false

	@Published private var items: [Product] = []
	@Published private var isLoading: Bool = false
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading}
	var itemsPublisher: Published<[Product]>.Publisher { $items }
	var itemsCount: Int { items.count }

	func retrieveData() {
		isCallretrieveData = true
	}
}
