//
//  RestaurantFiltering.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 24/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

protocol RestaurantFilterType {
    typealias filterHandler = (Restaurant,Restaurant) -> Bool
    
    var title: String { get set }
    var sortedBy:filterHandler { get }
    
    subscript (restaurant: Restaurant) -> String { get }
}

struct BestMatchFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.bestMatch > $1.sort.bestMatch }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.bestMatch)"
    }
}

struct NewestFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.newest > $1.sort.newest }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.newest)"
    }
}

struct RatingAverageFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.ratingAverage > $1.sort.ratingAverage }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.ratingAverage)"
    }
}

struct DistanceFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.distance > $1.sort.distance }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.distance)"
    }
}

struct PopularityFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.popularity > $1.sort.popularity }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.popularity)"
    }
}

struct AverageProductPriceFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.averageProductPrice > $1.sort.averageProductPrice }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.averageProductPrice)"
    }
}

struct DeliveryCostsFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.deliveryCosts > $1.sort.deliveryCosts }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.deliveryCosts)"
    }
}

struct MinCostFilter: RestaurantFilterType {
    var title: String
    let sortedBy: filterHandler = { $0.sort.minCost < $1.sort.minCost }
    
    subscript (restaurant: Restaurant) -> String {
        return "\(restaurant.sort.minCost)"
    }
}
