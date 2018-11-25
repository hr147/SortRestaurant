//
//  RestaurantViewModelMinCostTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest

@testable import SortRestaurant
class RestaurantViewModelMinCostTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .minCost)
        filter = { $0.sort.minCost <= $1.sort.minCost }
    }
}
