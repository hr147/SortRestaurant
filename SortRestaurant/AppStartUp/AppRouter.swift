//
//  AppCoordinator.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol Router {
    func installRoot()
}

class AppRouter: Router {
    
    private unowned let dependency:DependencyContainer
    
    var window:UIWindow?
    
    
    init(dependency:DependencyContainer) {
        self.dependency = dependency
    }
    
    func installRoot() {
        let controller = dependency.resturantController
        let navigationController = UINavigationController(rootViewController: controller)
        window = UIWindow(rootViewController: navigationController)
    }
}

