//
//  RestaurantViewModelNewestTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest

@testable import SortRestaurant
class RestaurantViewModelNewestTests: RestaurantViewModelBestMatchTests {
    
    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .newest)
        filter = { $0.sort.newest >= $1.sort.newest }
    }
}
