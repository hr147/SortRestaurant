//
//  RestaurantViewModel.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

protocol RestaurantViewModeling: class {
    //Inputs
    var count: Int { get }
    subscript (index:Int)-> Restaurant { get }
    func viewDidLoad()
    func restaurantDidSearch(withName name:String)
    func filterDidTouch()
    func filterDidSelect(atIndex index:Int)
    //outputs
    var refresh: Detectable<Void> { get }
    var filters: Detectable<[String]> { get }
}

class RestaurantViewModel {
    private let restaurantDataStore:RestaurantDataStore
    private var restaurants:[Restaurant] = []
    private let restaurantSorts:[RestaurantSort]
    private var currentSort:RestaurantSort
    
    let refresh: Detectable<Void> = Detectable(value: ())
    let filters: Detectable<[String]> = Detectable(value: [])
    
    init(restaurantDataStore:RestaurantDataStore,
         currentSort:RestaurantSort,
         restaurantSorts:[RestaurantSort]) {
        self.restaurantDataStore = restaurantDataStore
        self.currentSort = currentSort
        self.restaurantSorts = restaurantSorts
    }
    
    func fetchRestaurants(withRestaurantName name:String)  {
        restaurantDataStore.restaurants(withName: name) {[unowned self] result in
            guard case let .success(restaurants) = result else { return }
            self.processRestaurants(withRestaurants: restaurants)
        }
    }
    
    func processRestaurants(withRestaurants restaurants:[Restaurant]) {
        self.restaurants = currentSort.sorted(withRestaurants: restaurants)
        refresh.value = ()
        
    }
}

extension RestaurantViewModel: RestaurantViewModeling {
    
    func restaurantDidSearch(withName name: String) {
        fetchRestaurants(withRestaurantName: name)
    }
    
    func filterDidSelect(atIndex index: Int) {
        currentSort = restaurantSorts[index]
        processRestaurants(withRestaurants: restaurants)
    }
    
    func filterDidTouch() {
        filters.value =  restaurantSorts.map({ $0.title })
    }
    
    func viewDidLoad() {
        fetchRestaurants(withRestaurantName: "")
    }
    
    var count: Int {
        return restaurants.count
    }
    
    subscript(index: Int) -> Restaurant {
        return restaurants[index]
    }
}
