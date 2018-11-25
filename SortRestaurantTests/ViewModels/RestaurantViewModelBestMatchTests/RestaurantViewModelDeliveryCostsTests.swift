//
//  RestaurantViewModelDeliveryCostsTests.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import XCTest

@testable import SortRestaurant
class RestaurantViewModelDeliveryCostsTests: RestaurantViewModelBestMatchTests {

    override func setUp() {
        viewModelFactory = MockRestaurantViewModel(filterType: .deliveryCosts)
        filter = { $0.sort.deliveryCosts >= $1.sort.deliveryCosts }
    }
}
