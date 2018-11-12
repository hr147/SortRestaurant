//
//  StubRestaurantDataStore.swift
//  SortRestaurantTests
//
//  Created by Haroon Ur Rasheed on 12/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import Foundation
@testable import SortRestaurant

struct StubRestaurantDataStore: RestaurantDataStore {

    private var resturants:[Restaurant] = []
    
    init(bundle:Bundle,fileName:String,translate:ObjectTranslatable) {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            print("\(fileName) is not found."); return;
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            print("Data is not found in \(fileName)"); return;
        }
        
        do {
            let response:RestaurantResponseModel = try translate.translateToObject(withData: jsonData)
            resturants = response.restaurants
        } catch  {
            print(error)
        }
        
        
        
    }
    
    func restaurants(withName name:String, completion:ResultHandler<[Restaurant],RestaurantError>) {
        
        if name.isEmpty {
            completion(.success(resturants))
            return
        }
        
        let filteredResturants = resturants.filter { restaurant -> Bool in
            restaurant.name.lowercased().contains(name.lowercased())
        }
        
        completion(.success(filteredResturants))
    }
}
