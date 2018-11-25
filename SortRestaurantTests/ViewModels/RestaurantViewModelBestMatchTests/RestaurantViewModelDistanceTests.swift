//
//  RestaurantViewModelDistanceTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import SortRestaurant
class RestaurantViewModelDistanceTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .distance)
        filter = { $0.sort.distance >= $1.sort.distance }
    }
}
