//
//  ViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 22.08.2022.
//

import Foundation
import Combine

protocol CatalogViewModel {
	var numberOfItemsInSection: Int { get }
}

final class CatalogViewModelImpl {}

extension CatalogViewModelImpl: CatalogViewModel {
	var numberOfItemsInSection: Int {
		20
	}
}
