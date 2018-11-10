//
//  UIStoryboard+Names.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 09/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

extension UIStoryboard {

    enum Storyboard: String {
        case restaurant
        case filter
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = instantiateInitialViewController() as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.self) ")
        }
        
        return viewController
    }
}
