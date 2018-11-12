//
//  RestaurantError.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

enum RestaurantError: Error {
    
    enum FavouriteDataStoreFailureReason {
        case favouriteFailed(error: Error)
        case unFavouriteFailed(error: Error)
        case unFavouriteSaveFailed(error: Error)
        case favouriteFetchingFailed(error: Error)
    }
    
    case favouriteDataStoreFailed(reason: FavouriteDataStoreFailureReason)
    case invalid
}

struct RestaurantAdopterError:Error {
    let error:Error? = nil
}
