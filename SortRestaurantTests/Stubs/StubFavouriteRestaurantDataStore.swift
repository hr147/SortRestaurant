//
//  StubFavouriteRestaurantDataStore.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

@testable import SortRestaurant
struct StubFavouriteRestaurantDataStore: FavouriteRestaurantDataStore {

    func favourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
     completion(.success(true))
    }
    
    func unfavourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
        completion(.success(true))
    }
    
    func favourites(withName name: String, completion: @escaping ResultHandler<[String],RestaurantError>) {
        completion(.success([]))
    }
}


struct StubBestMatchFavouriteRestaurantDataStore: FavouriteRestaurantDataStore {
    
    func favourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
        completion(.success(true))
    }
    
    func unfavourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
        completion(.success(true))
    }
    
    func favourites(withName name: String, completion: @escaping ResultHandler<[String],RestaurantError>) {
        completion(.success(["Pizza Heart","Tandoori Express"]))
    }
}
