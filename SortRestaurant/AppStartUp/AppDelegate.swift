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
    private var router:Router!
    private var appStyle:AppStyling!
    
    private lazy var dependency: DependencyContainer = {
        return AppDependency()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        router = dependency.router
        appStyle = dependency.styling
        router.installRoot()
        appStyle.applyTheme()
        return true
    }
}

