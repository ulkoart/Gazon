//
//  HomeViewModel.swift
//  Project
//
//  Created by Улько Артем Викторович on 17.08.2022.
//

import Foundation

protocol HomeViewModel {
	var numberOfItemsInSection: Int { get }
}

final class HomeViewModelImpl: HomeViewModel {
	var numberOfItemsInSection: Int { 10 }
}
