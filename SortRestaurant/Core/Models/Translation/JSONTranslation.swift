//
//  JSONTranslation.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import Foundation

protocol ObjectTranslatable {
    func translateToObject<T:Decodable>(withData data:Data) throws -> T
}

struct JSONTranslation: ObjectTranslatable {
    
    func translateToObject<T>(withData data: Data) throws -> T where T : Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
