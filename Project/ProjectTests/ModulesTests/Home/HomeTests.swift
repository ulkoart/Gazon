//
//  ProjectTests.swift
//  ProjectTests
//
//  Created by Улько Артем Викторович on 13.09.2022.
//

@testable import Project
import XCTest

class HomeTests: XCTestCase {

	func testCreateHomeController() {
		// Arrange
		let sut = HomeController()

		// Assert
		XCTAssertNotNil(sut, "HomeController не создан")
	}

	func testCreateHomeControllerWithFactory() {
		// Arrange
		let factory = HomeFactory.self

		// Act
		let sut = factory.createModule()

		// Assert
		XCTAssertNotNil(sut, "HomeFactory не создал HomeController")
		XCTAssertEqual(sut.navigationItem.title, "Информация")
	}

	func testHomeControllerCalledRetrieveData() {
		// Arrange
		let sut = HomeController()
		let homeViewModelMock = HomeViewModelMock()
		sut.viewModel = homeViewModelMock

		// Act
		sut.viewDidLoad()

		// Assert
		XCTAssertTrue(homeViewModelMock.isCallretrieveData, "Метод retrieveData не вызывался")
	}
}
