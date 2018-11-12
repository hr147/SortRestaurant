//
//  RestaurantSorting.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//
struct RestaurantSort {
    let title: String
    let sorting: RestaurantSorting
    
    init(_ title:String, _ sorting:RestaurantSorting) {
        self.title = title
        self.sorting = sorting
    }
    
    func sorted(withFavourites favouirtes:[String], withRestaurants restaurants:[Restaurant]) -> [Restaurant] {
        
        if restaurants.isEmpty {
            return []
        }
        
        restaurants.forEach {
            $0.currentSortTitle = title
            $0.isFavourite = false
        }
        
        let sortedResturants = sorting.sorted(withRestaurants: restaurants)
        
        let resturantsByStatus = groupedByStatus(sortedResturants)
        
        if favouirtes.isEmpty {
            return resturantsByStatus
        }
        return groupedByFavourite(favouirtes,resturantsByStatus)
    }
    
    
    private func groupedByStatus(_ restaurants:[Restaurant]) -> [Restaurant] {
        
        let openResturants = restaurants.filter { $0.status == .open }
        let orderResturants = restaurants.filter { $0.status == .order }
        let closeResturants = restaurants.filter { $0.status == .close }
        
        return openResturants + orderResturants + closeResturants
        
    }
    
    private func groupedByFavourite(_ favouirtes:[String], _ restaurants:[Restaurant]) -> [Restaurant] {
        
        restaurants.forEach {
            if favouirtes.contains($0.name){
                $0.isFavourite = true
            }
        }
        
        let favRestaurants = restaurants.filter { $0.isFavourite }
        let unfavRestaurants = restaurants.filter { $0.isFavourite == false }
        
        return favRestaurants + unfavRestaurants
        
    }
}
