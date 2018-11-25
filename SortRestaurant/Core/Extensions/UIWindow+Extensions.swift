//
//  UIWindow+Extensions.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

extension UIWindow {

    convenience init(rootViewController: UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = rootViewController
        self.makeKeyAndVisible()
    }
}
