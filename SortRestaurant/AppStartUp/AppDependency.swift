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
    var resturantController: RestaurantTableViewController { get }
}

class AppDependency: DependencyContainer {
    var router: Router {
        return AppRouter(dependency: self)
    }
    
    var resturantController: RestaurantTableViewController {
        let storyboard:UIStoryboard = .init(storyboard: .restaurant)
        let controller:RestaurantTableViewController = storyboard.instantiateViewController()
        return controller
    }
}
