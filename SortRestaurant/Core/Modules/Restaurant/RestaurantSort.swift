//
//  RestaurantSorting.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

/*
 "bestMatch": 306.0,
 "newest": 259.0,
 "ratingAverage": 3.5,
 "distance": 14201,
 "popularity": 0.0,
 "averageProductPrice": 4465,
 "deliveryCosts": 500,
 "minCost": 5000*/
struct RestaurantSort {
    let title: String
    let sorting: RestaurantSorting
    
    init(_ title:String, _ sorting:RestaurantSorting) {
        self.title = title
        self.sorting = sorting
    }
    
    func sorted(withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        let sortedResturants = sorting.sorted(withRestaurants: restaurants, withTitle: title)
        
        let openResturants = sortedResturants.filter { $0.status == .open }
        let orderResturants = sortedResturants.filter { $0.status == .order }
        let closeResturants = sortedResturants.filter { $0.status == .close }
        
        return openResturants + orderResturants + closeResturants
        
    }
}

protocol RestaurantSorting {
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant]
}

struct BestMatchSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
      
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.bestMatch)"
        }
        
        return restaurants.sorted {
            $0.sort.bestMatch > $1.sort.bestMatch
        }
    }
}

struct NewestSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.newest)"
        }
        
        return restaurants.sorted {
            $0.sort.newest > $1.sort.newest
        }
    }
}

struct RatingAverageSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.ratingAverage)"
        }
        
        return restaurants.sorted {
            $0.sort.ratingAverage > $1.sort.ratingAverage
        }
    }
}

struct DistanceSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.distance)"
        }
        
        return restaurants.sorted {
            $0.sort.distance > $1.sort.distance
        }
    }
}

struct PopularitySort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.popularity)"
        }
        
        return restaurants.sorted {
            $0.sort.popularity > $1.sort.popularity
        }
    }
}

struct AverageProductPriceSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.averageProductPrice)"
        }
        
        return restaurants.sorted {
            $0.sort.averageProductPrice > $1.sort.averageProductPrice
        }
    }
}

struct DeliveryCostsSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.deliveryCosts)"
        }
        
        return restaurants.sorted {
            $0.sort.deliveryCosts > $1.sort.deliveryCosts
        }
    }
}

struct MinCostSort: RestaurantSorting {
    
    func sorted(withRestaurants restaurants:[Restaurant], withTitle title:String) -> [Restaurant] {
        
        restaurants.forEach { restaurant in
            restaurant.currentSortTitle = title
            restaurant.currentSortValue = "\(restaurant.sort.minCost)"
        }
        
        return restaurants.sorted {
            $0.sort.minCost < $1.sort.minCost
        }
    }
}
