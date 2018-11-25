//
//  RestaurantViewModelAverageProductPriceTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import SortRestaurant
class RestaurantViewModelAverageProductPriceTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .averageProductPrice)
        filter = { $0.sort.averageProductPrice >= $1.sort.averageProductPrice }
    }
}
