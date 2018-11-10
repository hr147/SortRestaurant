//
//  Restaurant.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

struct Restaurant: Decodable {
    
    enum Status:String,Decodable {
        case open = "open"
        case close = "closed"
        case order = "order ahead"
    }
    
    let name:String
    let status:Status
}
