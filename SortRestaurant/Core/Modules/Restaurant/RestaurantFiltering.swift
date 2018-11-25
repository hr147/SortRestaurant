//
//  RestaurantFiltering.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 24/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//



protocol RestaurantFiltering {
    typealias filterHandler = (Restaurant,Restaurant) -> Bool
    var title: String { get set }
    var sortedBy:filterHandler { get }
    func value(from restaurant:Restaurant) -> String
}

struct BestMatchFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.bestMatch > $1.sort.bestMatch }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.bestMatch)"
    }
}

struct NewestFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.newest > $1.sort.newest }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.newest)"
    }
}

struct RatingAverageFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.ratingAverage > $1.sort.ratingAverage }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.ratingAverage)"
    }
}

struct DistanceFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.distance > $1.sort.distance }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.distance)"
    }
}

struct PopularityFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.popularity > $1.sort.popularity }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.popularity)"
    }
}

struct AverageProductPriceFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.averageProductPrice > $1.sort.averageProductPrice }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.averageProductPrice)"
    }
}

struct DeliveryCostsFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.deliveryCosts > $1.sort.deliveryCosts }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.deliveryCosts)"
    }
}

struct MinCostFilter: RestaurantFiltering {
    var title: String
    let sortedBy: filterHandler = { $0.sort.minCost < $1.sort.minCost }
    
    func value(from restaurant: Restaurant) -> String {
        return "\(restaurant.sort.minCost)"
    }
}
