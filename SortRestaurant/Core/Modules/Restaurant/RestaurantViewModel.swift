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
    func favouriteStatusDidChange(atIndex index:Int)
    //outputs
    var refresh: Detectable<Void> { get }
    var filters: Detectable<[String]> { get }
}

class RestaurantViewModel {
    private let restaurantDataStore:RestaurantDataStore
    private let restaurantFavouriteDataStore:FavouriteRestaurantDataStore
    private var restaurants:[Restaurant] = []
    private let restaurantSorts:[RestaurantSort]
    private var currentSort:RestaurantSort
    private let messageWireFrame:MessageWireframe
    
    let refresh: Detectable<Void> = Detectable(value: ())
    let filters: Detectable<[String]> = Detectable(value: [])
    
    init(restaurantDataStore:RestaurantDataStore,
         restaurantFavouriteDataStore:FavouriteRestaurantDataStore,
         messageWireFrame:MessageWireframe,
         currentSort:RestaurantSort,
         restaurantSorts:[RestaurantSort]) {
        self.restaurantDataStore = restaurantDataStore
        self.currentSort = currentSort
        self.restaurantSorts = restaurantSorts
        self.restaurantFavouriteDataStore = restaurantFavouriteDataStore
        self.messageWireFrame = messageWireFrame
    }
    
    private func fetchRestaurants(withRestaurantName name:String)  {
        restaurantDataStore.restaurants(withName: name) {[unowned self] result in
            guard case let .success(restaurants) = result else { return }
            self.processRestaurants(withRestaurants: restaurants)
        }
    }
    
    private func processRestaurants(withRestaurants restaurants:[Restaurant]) {
        
        restaurantFavouriteDataStore.favourites(withName: "") {[unowned self] result in
            var favourites:[String] = []
            if case let .success(storedFavourites) = result {
                favourites = storedFavourites
            }
            self.restaurants = self.currentSort.sorted(withFavourites: favourites, withRestaurants: restaurants)
            self.refresh.value = ()
        }
    }
    
    private func favourite(restuarant: Restaurant) {
        restaurantFavouriteDataStore.favourite(name: restuarant.name) {[unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:self.processRestaurants(withRestaurants: self.restaurants)
                case .failure(let error):
                    print("\(error)")
                    self.messageWireFrame.show(withMessage: "favourite failed. Please try again.")
                }
            }
        }
    }
    
    private func unFavourite(restuarant: Restaurant) {
        restaurantFavouriteDataStore.unfavourite(name: restuarant.name) {[unowned self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:self.processRestaurants(withRestaurants: self.restaurants)
                case .failure(let error):
                    print("\(error)")
                    self.messageWireFrame.show(withMessage: "un favourite failed. Please try again.")
                }
            }
        }
    }
}

extension RestaurantViewModel: RestaurantViewModeling {
    
    func favouriteStatusDidChange(atIndex index: Int) {
        let restaurant = self[index]
        
        if restaurant.isFavourite {
            unFavourite(restuarant: restaurant)
        }else{
            favourite(restuarant: restaurant)
        }
        
    }
    
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
