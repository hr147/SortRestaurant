//
//  AppCoordinator.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

protocol Router {
    func installRoot(withWindow window:UIWindow?)
}

class AppRouter: Router {
    
   private unowned let dependency:DependencyContainer
    
    init(dependency:DependencyContainer) {
        self.dependency = dependency
    }
    
    func installRoot(withWindow window: UIWindow?) {
        
    }
}

