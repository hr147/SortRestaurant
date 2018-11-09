//
//  AppDelegate.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 08/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var router:Router!
    
    private lazy var dependency: DependencyContainer = {
        return AppDependency()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router = dependency.router
        window = UIWindow(frame: UIScreen.main.bounds)
        router.installRoot(withWindow: window)
        window?.makeKeyAndVisible()
        return true
    }
}

