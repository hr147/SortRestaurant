//
//  AppDependency.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol DependencyContainer: class {
    var router: Router { get }
    var styling: AppStyling { get }
    var resturantController: RestaurantTableViewController { get }
    func filterController(withFilters filters:[String]) -> RestaurantFilterController
}

class AppDependency: DependencyContainer {
    var router: Router {
        return AppRouter(dependency: self)
    }
    
    var styling: AppStyling{
        return AppStyle()
    }
    
    var resturantController: RestaurantTableViewController {
        
        let defaultSort = RestaurantSort("Best Match",BestMatchSort())
        
        let sorts = [
            defaultSort,
            RestaurantSort("Newest",NewestSort()),
            RestaurantSort("Rating Average",RatingAverageSort()),
            RestaurantSort("Distance",DistanceSort()),
            RestaurantSort("Popularity",PopularitySort()),
            RestaurantSort("Average Product Price",AverageProductPriceSort()),
            RestaurantSort("Delivery Costs",DeliveryCostsSort()),
            RestaurantSort("Min Cost",MinCostSort())
        ]
        
        let dataStore = JSONRestaurantDataStore(translate: JSONTranslation())
        let favouriteDataStore = CoreDataFavouriteRestaurantDataStore()
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            currentSort: defaultSort,
            restaurantSorts: sorts)
        
        let storyboard:UIStoryboard = .init(storyboard: .restaurant)
        let controller:RestaurantTableViewController = storyboard.instantiateViewController()
        controller.restaurantViewModel = viewModel
        controller.dependency = self
        return controller
    }
    
    func filterController(withFilters filters:[String]) -> RestaurantFilterController{
        let storyboard:UIStoryboard = .init(storyboard: .filter)
        let controller:RestaurantFilterController = storyboard.instantiateViewController()
        controller.filterDataSource = filters
        return controller
    }
    
}
