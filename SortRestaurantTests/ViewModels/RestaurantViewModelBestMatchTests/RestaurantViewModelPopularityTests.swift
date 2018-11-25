//
//  RestaurantViewModelPopularityTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest
@testable import SortRestaurant
class RestaurantViewModelPopularityTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .popularity)
        filter = { $0.sort.popularity >= $1.sort.popularity }
    }
}
