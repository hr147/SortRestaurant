//
//  RestaurantMO+CoreDataProperties.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//
//

import Foundation
import CoreData


extension RestaurantMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantMO> {
        return NSFetchRequest<RestaurantMO>(entityName: "Restaurant")
    }

    @NSManaged public var name: String?

}
