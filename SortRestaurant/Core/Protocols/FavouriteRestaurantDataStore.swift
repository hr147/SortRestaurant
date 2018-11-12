//
//  FavouriteRestaurantDataStore.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

protocol FavouriteRestaurantDataStore {
    func favourite(name:String,completion: @escaping ResultHandler<Bool,RestaurantError>)
    func unfavourite(name:String, completion: @escaping ResultHandler<Bool,RestaurantError>)
    func favourites(withName name:String, completion: @escaping ResultHandler<[String],RestaurantError>)
}
