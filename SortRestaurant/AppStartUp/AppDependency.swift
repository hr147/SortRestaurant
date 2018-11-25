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
    
        let storyboard:UIStoryboard = .init(storyboard: .restaurant)
        let controller:RestaurantTableViewController = storyboard.instantiateViewController()
        let defaultFilter = BestMatchFilter(title: "Best Match")
        
        let filters:[RestaurantFiltering] = [
            defaultFilter,
            NewestFilter(title: "Newest"),
            RatingAverageFilter(title: "Rating Average"),
            DistanceFilter(title: "Distance"),
            PopularityFilter(title: "Popularity"),
            AverageProductPriceFilter(title: "Average Product Price"),
            DeliveryCostsFilter(title: "Delivery Costs"),
            MinCostFilter(title: "Min Cost")
        ]
        
        let dataStore = JSONRestaurantDataStore(fileName: "sample iOS", translate: JSONTranslation())
        let favouriteDataStore = CoreDataFavouriteRestaurantDataStore()
        let wireFrame = AlertMessageWireframe(source: controller)
        
        let viewModel = RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            currentFilter: defaultFilter,
            filters: filters)
        
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
