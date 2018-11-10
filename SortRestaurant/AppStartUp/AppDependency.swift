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
        let dataStore = JSONRestaurantDataStore(translate: JSONTranslation())
        let viewModel = RestaurantViewModel(restaurantDataStore: dataStore)
        
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
