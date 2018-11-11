//
//  RestaurantSort.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
/*
 "bestMatch": 306.0,
 "newest": 259.0,
 "ratingAverage": 3.5,
 "distance": 14201,
 "popularity": 0.0,
 "averageProductPrice": 4465,
 "deliveryCosts": 500,
 "minCost": 5000
 */
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
