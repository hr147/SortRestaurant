//
//  RestaurantViewModel.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

protocol RestaurantViewModeling: class {
    var count: Int { get }
    subscript (index:Int)-> Restaurant { get }
    func viewDidLoad()
    
    var refresh: Detectable<Void> { get }
}

class RestaurantViewModel {
    private let restaurantDataStore:RestaurantDataStore
    private var restaurants:[Restaurant] = []
    
    let refresh: Detectable<Void> = Detectable(value: ())
    
    init(restaurantDataStore:RestaurantDataStore) {
        self.restaurantDataStore = restaurantDataStore
    }
    
    func fetchRestaurants(withRestaurantName name:String)  {
        restaurantDataStore.restaurants(withName: name) {[unowned self] result in
            switch result {
            case .success(let restaurants):
                self.processRestaurants(withRestaurants: restaurants)
            case .failure(let error):break
            }
        }
    }
    
    func processRestaurants(withRestaurants restaurants:[Restaurant]) {
        self.restaurants = restaurants
        refresh.value = ()
        
    }
}

extension RestaurantViewModel: RestaurantViewModeling {
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
