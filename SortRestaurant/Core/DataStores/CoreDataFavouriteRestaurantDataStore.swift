//
//  CoreDataFavouriteRestaurantDataStore.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//


import CoreData

final class CoreDataFavouriteRestaurantDataStore {
    let persistence:CoreDataPersistence
    
    init(persistence:CoreDataPersistence = CoreDataPersistence()) {
        self.persistence = persistence
    }
}

extension CoreDataFavouriteRestaurantDataStore: FavouriteRestaurantDataStore {
    func favourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
        persistence.performBackgroundTask { (context) in
            let restaurantMO = RestaurantMO(context: context)
            restaurantMO.name = name
            do {
                try context.save()
                completion(.success(true))
            } catch {
                completion(.failure(.favouriteDataStoreFailed(reason: .favouriteFailed(error: error))))
            }
        }
    }
    
    func unfavourite(name: String, completion: @escaping ResultHandler<Bool,RestaurantError>) {
        persistence.performBackgroundTask { (context) in
            let restaurantFR : NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
            restaurantFR.predicate = NSPredicate(format: "name = %@", name)
            
            do {
                if let restaurantMO = try context.fetch(restaurantFR).first{
                    context.delete(restaurantMO)
                }
                
                do{
                    try context.save()
                    
                }catch{
                    completion(.failure(.favouriteDataStoreFailed(reason: .unFavouriteSaveFailed(error: error))))
                }
                
                completion(.success(true))
            } catch {
                completion(.failure(.favouriteDataStoreFailed(reason: .unFavouriteFailed(error: error))))
            }
        }
    }
    
    func favourites(withName name: String, completion: @escaping ResultHandler<[String],RestaurantError>) {
        persistence.performViewTask { (context) in
            let restaurantFR : NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
            //restaurantFR.predicate = NSPredicate(format: "name contains[c]  %@", name)
            do {
                restaurantFR.returnsObjectsAsFaults = false
                let res = try context.fetch(restaurantFR)
                completion(.success(res.compactMap({ $0.name })))
            } catch  {
                completion(.failure(.favouriteDataStoreFailed(reason: .favouriteFetchingFailed(error: error))))
            }
        }
    }
}
