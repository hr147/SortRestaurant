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
    var filterNames: Detectable<(names:[String],selectedIndex:Int)> { get }
}

final class RestaurantViewModel {
    private let restaurantDataStore:RestaurantDataStore
    private let restaurantFavouriteDataStore:FavouriteRestaurantDataStore
    private let restaurantSort = RestaurantSort()
    
    private var restaurants:[Restaurant] = []
    private let filters:[RestaurantFiltering]
    private var activeFilter:RestaurantFiltering
    
    private let messageWireFrame:MessageWireframe
    
    let refresh: Detectable<Void> = Detectable(value: ())
    let filterNames: Detectable<(names:[String],selectedIndex:Int)> = Detectable(value: ([],0))
    
    
    /// MARK: Init
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
         currentFilter:RestaurantFiltering,
         filters:[RestaurantFiltering]) {
        self.restaurantDataStore = restaurantDataStore
        self.activeFilter = currentFilter
        self.filters = filters
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
            // load sorted restaurants based on active filter
            self.restaurants = self.restaurantSort.sorted(
                withFavourites: favourites,
                withRestaurants: restaurants,
                withFilter: self.activeFilter)
            
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
        activeFilter = filters[index]
        processRestaurants(withRestaurants: restaurants)
    }
    
    func filterDidTouch() {
        let names = filters.map({ $0.title })
        let filterSelectedRowIndex = filters.firstIndex(where: { $0.title == activeFilter.title }) ?? 0
        filterNames.value = (names,filterSelectedRowIndex)
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
