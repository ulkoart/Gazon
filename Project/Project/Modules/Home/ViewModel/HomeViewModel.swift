//
//  HomeViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import Foundation
import Combine

protocol HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { get }

	var code: String? { get }
	var blocksCount: Int { get }

	func retrieveData()
}

final class HomeViewModelImpl: ObservableObject {
	let shippingProvider: ApiServiceProvider<ShippingReceivingService>

	@Published private var isLoading: Bool = false

	var code: String?

	init(provider: ApiServiceProvider<ShippingReceivingService> = ApiServiceProvider<ShippingReceivingService>()) {
		self.shippingProvider = provider
	}
}

extension HomeViewModelImpl: HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
	var blocksCount: Int { 2 }


	func retrieveData() {
		self.isLoading = true
		var code: String?
		let group = DispatchGroup()
		
		group.enter()
		shippingProvider.load(service: .deliveryCode(userID: "1234"), decodeType: DeliveryCode.self) { result in
			defer { group.leave() }
			switch result {
			case let .success(deliveryCode):
				code = deliveryCode.code
			case let .failure(error):
				fatalError("Нужно обрабатывать ошибки сети! \(error)")
			}
		}

		group.notify(queue: .main) {
			self.code = code
			self.isLoading = false
		}
	}
}
