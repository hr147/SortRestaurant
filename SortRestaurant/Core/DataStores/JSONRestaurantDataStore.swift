//
//  JSONRestaurantDataStore.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import UIKit

struct JSONRestaurantDataStore: RestaurantDataStore {
    
    private var resturants:[Restaurant] = []
    
    init(translate:ObjectTranslatable) {
        
        let fileName = "sample iOS"
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("\(fileName) is not found."); return;
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            print("Data is not found in \(fileName)"); return;
        }
        
        guard let response:RestaurantResponseModel = try? translate.translateToObject(withData: jsonData) else { return }
        
        resturants = response.restaurants
    }
    
    func restaurants(withName name:String, completion:ResultHandler<[Restaurant],RestaurantError>) {
        
        if name.isEmpty {
            completion(.success(resturants))
            return
        }
        
        let filteredResturants = resturants.filter { restaurant -> Bool in
            restaurant.name.contains(name)
        }
        
        completion(.success(filteredResturants))
    }
    
    
}
