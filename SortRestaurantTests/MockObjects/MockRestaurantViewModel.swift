//
//  MockRestaurantViewModelFactory.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 24/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit
@testable import SortRestaurant

enum JSONFileName:String {
    case sample1 = "Sample1"
    case sample2 = "Sample2"
    case sample3 = "Sample3"
    case sample4 = "Sample4"
    
    var name:String {
        return rawValue
    }
    
}


enum FilterType: String {
    case bestMatch = "Best Match"
    case newest = "Newest"
    case ratingAverage = "Rating Average"
    case distance = "Distance"
    case popularity = "Popularity"
    case averageProductPrice = "Average Product Price"
    case deliveryCosts = "Delivery Costs"
    case minCost = "Min Cost"
    
    var title: String {
        return rawValue
    }
    
    var filter: RestaurantFilterType {
        switch self {
        case .bestMatch: return BestMatchFilter(title: title)
        case .newest: return NewestFilter(title: title)
        case .ratingAverage: return RatingAverageFilter(title: title)
        case .distance: return DistanceFilter(title: title)
        case .popularity: return PopularityFilter(title: title)
        case .averageProductPrice: return AverageProductPriceFilter(title: title)
        case .deliveryCosts: return DeliveryCostsFilter(title: title)
        case .minCost: return MinCostFilter(title: title)
            
        }
    }
}

enum FavouriteStub {
    case empty
    case favourite
    
    var favouriteDataSource:FavouriteRestaurantDataStore {
        switch self {
        case .empty: return StubFavouriteRestaurantDataStore()
        case .favourite: return StubFilledFavouriteRestaurantDataStore()
        }
    }
    
}

class MockRestaurantViewModel {
    let filterType:FilterType
    
    init(filterType:FilterType) {
        self.filterType = filterType
    }
    
    func viewModel(file: JSONFileName = .sample1, favourite: FavouriteStub = .empty) -> RestaurantViewModeling {
        let defaultFilter = filterType.filter
        let filters:[RestaurantFilterType] = [defaultFilter]
        let testBundle:Bundle = Bundle(for: type(of: self))
        let favouriteDataStore = favourite.favouriteDataSource
        let wireFrame = StubMessageWireframe()
        
        let dataStore = StubRestaurantDataStore(
            bundle:testBundle,
            fileName:file.name,
            translate:JSONTranslation())
        
        let filter = RestaurantFilter(filters: filters, activeFilter: defaultFilter)
        
        return RestaurantViewModel(
            restaurantDataStore: dataStore,
            restaurantFavouriteDataStore: favouriteDataStore,
            messageWireFrame: wireFrame,
            restaurantFilter: filter
        )
    }
}
