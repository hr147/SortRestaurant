//
//  RestaurantSorting.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

protocol RestaurantFilterable {
    var names:[String] { get }
    var indexOfActiveFilter: Int { get }
    
    func activate(for index:Int)
    func sorted(_ favouirtes:[String],_ restaurants:[Restaurant]) -> [Restaurant]
}

final class RestaurantFilter {
    private let filters:[RestaurantFilterType]
    private var activeFilter:RestaurantFilterType
    
    init(filters:[RestaurantFilterType], activeFilter:RestaurantFilterType) {
        self.filters = filters
        self.activeFilter = activeFilter
    }
    
    private func groupedByStatus(_ restaurants:[Restaurant]) -> [Restaurant] {
        let openResturants = restaurants.filter { $0.status == .open }
        let orderResturants = restaurants.filter { $0.status == .order }
        let closeResturants = restaurants.filter { $0.status == .close }
        
        return openResturants + orderResturants + closeResturants
    }
    
    private func groupedByFavourite(_ favouirtes:[String], _ restaurants:[Restaurant]) -> [Restaurant] {
        restaurants.forEach {
            if favouirtes.contains($0.name) { $0.isFavourite = true }
        }
        
        let favRestaurants = restaurants.filter { $0.isFavourite }
        let unfavRestaurants = restaurants.filter { $0.isFavourite == false }
        
        return favRestaurants + unfavRestaurants
    }
}

extension RestaurantFilter: RestaurantFilterable {
    var names: [String] {
        return filters.map({ $0.title })
    }
    
    var indexOfActiveFilter: Int {
        return filters.firstIndex(where: { $0.title == activeFilter.title }) ?? 0
    }
    
    func activate(for index: Int) {
        activeFilter = filters[index]
    }
    
    func sorted(_ favouirtes: [String],_ restaurants: [Restaurant]) -> [Restaurant] {
        if restaurants.isEmpty { return [] }
        
        restaurants.forEach {
            $0.currentSortTitle = activeFilter.title
            $0.currentSortValue = activeFilter[$0]
            $0.isFavourite = false
        }
        
        let sortedResturants = restaurants.sorted(by: activeFilter.sortedBy)
        let resturantsByStatus = groupedByStatus(sortedResturants)
        
        if favouirtes.isEmpty { return resturantsByStatus }
        
        return groupedByFavourite(favouirtes,resturantsByStatus)
    }
}
