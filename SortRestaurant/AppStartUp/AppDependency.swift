//
//  AppDependency.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

protocol DependencyContainer: class {
    var router: Router { get }
}

class AppDependency: DependencyContainer {
    var router: Router {
        return AppRouter(dependency: self)
    }
}
