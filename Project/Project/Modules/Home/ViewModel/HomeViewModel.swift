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
	var numberOfXLBanners: Int? { get }

	/// Количество блоков на домашнем экране
	var blocksCount: Int { get }

	func retrieveData()
}

final class HomeViewModelImpl: ObservableObject {
	let shippingProvider: ApiServiceProvider<ShippingReceivingService>

	@Published private var isLoading: Bool = false

	var code: String?
	var numberOfXLBanners: Int?

	init(
		shippingProvider: ApiServiceProvider<ShippingReceivingService> = ApiServiceProvider<ShippingReceivingService>()
	) {
		self.shippingProvider = shippingProvider
	}
}

extension HomeViewModelImpl: HomeViewModel {
	var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
	var blocksCount: Int { 2 }

	func retrieveData() {
		self.isLoading = true
		var code: String?
		var numberOfXLBanners: Int?
		let group = DispatchGroup()

		// TODO: numberOfXLBanners нужно брать из конфига (сделать конфиг)
		// TODO: - добавить использование сервиса для получения баннеров XL главного экрана

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
			self.numberOfXLBanners = numberOfXLBanners
		}
	}
}
