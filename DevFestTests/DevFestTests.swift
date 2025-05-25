//
//  DevFestTests.swift
//  DevFestTests
//
//  Created by Raj Salla on 2025-05-25.
//

import XCTest
@testable import DevFest

final class DevFestTests: XCTestCase {
    
    func testAddingProductInViewModel() {
        // Arrange
        let viewModel = ProductViewModel()
        let initialCount = viewModel.products.count

        let newProduct = Product(
            id: 123,
            title: "Test Product",
            price: 99.99,
            description: "This is a test product",
            category: "Test Category",
            image: "https://example.com/image.jpg",
            rating: Rate(rate: 4.0, count: 100)
        )

        // Act
        viewModel.addProductLocally(newProduct)

        // Assert
        XCTAssertEqual(viewModel.products.count, initialCount + 1, "Product should be added to the view model")
    }
}

