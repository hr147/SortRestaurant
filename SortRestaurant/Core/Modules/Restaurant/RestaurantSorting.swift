//
//  RestaurantSorting.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

protocol RestaurantSorting {
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant]
}

struct BestMatchSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.bestMatch)"
        }
        
        return restaurants.sorted {
            $0.sort.bestMatch > $1.sort.bestMatch
        }
    }
}

struct NewestSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.newest)"
        }
        
        return restaurants.sorted {
            $0.sort.newest > $1.sort.newest
        }
    }
}

struct RatingAverageSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.ratingAverage)"
        }
        
        return restaurants.sorted {
            $0.sort.ratingAverage > $1.sort.ratingAverage
        }
    }
}

struct DistanceSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.distance)"
        }
        
        return restaurants.sorted {
            $0.sort.distance > $1.sort.distance
        }
    }
}

struct PopularitySort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.popularity)"
        }
        
        return restaurants.sorted {
            $0.sort.popularity > $1.sort.popularity
        }
    }
}

struct AverageProductPriceSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.averageProductPrice)"
        }
        
        return restaurants.sorted {
            $0.sort.averageProductPrice > $1.sort.averageProductPrice
        }
    }
}

struct DeliveryCostsSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.deliveryCosts)"
        }
        
        return restaurants.sorted {
            $0.sort.deliveryCosts > $1.sort.deliveryCosts
        }
    }
}

struct MinCostSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            $0.currentSortValue = "\($0.sort.minCost)"
        }
        
        return restaurants.sorted {
            $0.sort.minCost < $1.sort.minCost
        }
    }
}
