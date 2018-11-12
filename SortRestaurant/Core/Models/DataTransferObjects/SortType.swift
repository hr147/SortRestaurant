//
//  RestaurantSort.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

struct SortType: Decodable {
    let bestMatch: Float
    let newest: Float
    let ratingAverage: Float
    let distance: Int
    let popularity: Float
    let averageProductPrice: Int
    let deliveryCosts: Int
    let minCost: Int
}
