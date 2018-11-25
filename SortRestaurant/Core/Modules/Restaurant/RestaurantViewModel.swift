//
//  RestaurantViewModel.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

protocol RestaurantViewModeling: class {
    /// ViewModel Input messages
    var count: Int { get }
    subscript (index:Int)-> Restaurant { get }
    func viewDidLoad()
    func restaurantDidSearch(withName name:String)
    func filterDidTouch()
    func filterDidSelect(atIndex index:Int)
    func favouriteStatusDidChange(atIndex index:Int)
    
    /// ViewModel Output Obserables
    var refresh: Detectable<Void> { get }
    var filterNames: Detectable<(names:[String],selectedIndex:Int)> { get }
}

final class RestaurantViewModel {
    /// Properties for to get restuarants
    private let restaurantDataStore:RestaurantDataStore
    private let restaurantFavouriteDataStore:FavouriteRestaurantDataStore
    
    /// to get filtered and sorted restuarants
    private let restaurantFilter:RestaurantFilterable
    
    private var restaurants:[Restaurant] = []
    
    /// use for show alert messages
    private let messageWireFrame:MessageWireframe
    
    /// ViewModel Output obserables
    let refresh: Detectable<Void> = Detectable(value: ())
    let filterNames: Detectable<(names:[String],selectedIndex:Int)> = Detectable(value: ([],0))
    
    
    /// initialize viewmodel
    ///
    /// - Parameters:
    ///   - restaurantDataStore: privide list of restaurants
    ///   - restaurantFavouriteDataStore: privide list of stored favourite restaurants
    ///   - messageWireFrame: show pop up messages
    ///   - currentFilter: default filter
    ///   - filters: list of all filters
    init(restaurantDataStore:RestaurantDataStore,
         restaurantFavouriteDataStore:FavouriteRestaurantDataStore,
         messageWireFrame:MessageWireframe,
         restaurantFilter:RestaurantFilterable
         ) {
        self.restaurantDataStore = restaurantDataStore
        self.restaurantFavouriteDataStore = restaurantFavouriteDataStore
        self.messageWireFrame = messageWireFrame
        self.restaurantFilter = restaurantFilter
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
            // load sorted restaurants based on active filter
            self.restaurants = self.restaurantFilter.sorted(favourites, restaurants)
            
            self.refresh.value = ()
        }
    }
    
    private func processFavouriteResult(result:DataResult<Bool, RestaurantError>) {
        DispatchQueue.main.async {[unowned self] in
            switch result {
            case .success:self.processRestaurants(withRestaurants: self.restaurants)
            case .failure(let error):
                self.messageWireFrame.show(withMessage: error.localizedDescription)
            }
        }
    }
    
    private func favourite(name: String) {
        restaurantFavouriteDataStore.favourite(name: name) {[unowned self] result in
            self.processFavouriteResult(result: result)
        }
    }
    
    private func unFavourite(name: String) {
        restaurantFavouriteDataStore.unfavourite(name: name) {[unowned self] result in
            self.processFavouriteResult(result: result)
        }
    }
}

extension RestaurantViewModel: RestaurantViewModeling {
    func favouriteStatusDidChange(atIndex index: Int) {
        let restaurant = self[index]
        
        if restaurant.isFavourite {
            unFavourite(name: restaurant.name)
        }else{
            favourite(name: restaurant.name)
        }
    }
    
    func restaurantDidSearch(withName name: String) {
        fetchRestaurants(withRestaurantName: name)
    }
    
    func filterDidSelect(atIndex index: Int) {
        restaurantFilter.activate(for: index)
        processRestaurants(withRestaurants: restaurants)
    }
    
    func filterDidTouch() {
        filterNames.value = (restaurantFilter.names,restaurantFilter.indexOfActiveFilter)
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
