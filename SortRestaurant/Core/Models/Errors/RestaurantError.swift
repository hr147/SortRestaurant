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
        case favouriteFailed(error: Error?)
        case unFavouriteFailed(error: Error?)
        case unFavouriteSaveFailed(error: Error?)
        case favouriteFetchingFailed(error: Error?)
    }
    
    case favouriteDataStoreFailed(reason: FavouriteDataStoreFailureReason)
    case invalid
}

extension RestaurantError.FavouriteDataStoreFailureReason {
    var localizedDescription: String {
        switch self {
        case .favouriteFailed, .favouriteFetchingFailed:
            return "Favourite has been failed. Please try again. "
        case .unFavouriteFailed, .unFavouriteSaveFailed:
            return "UnFavourite has been failed Please try again. "
        }
    }
}

extension RestaurantError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalid:
            return "Something went wrong"
        case .favouriteDataStoreFailed(let reason):
            return reason.localizedDescription
        }
    }
}
