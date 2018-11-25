//
//  RestaurantViewModelRaitingAverageTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import SortRestaurant

class RestaurantViewModelRaitingAverageTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .ratingAverage)
        filter = { $0.sort.ratingAverage >= $1.sort.ratingAverage }
    }
}
