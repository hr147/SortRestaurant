//
//  Detectable.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//



class Detectable<Element> {
    var subscribe:((Element)->Void)?
    
    var value:Element {
        didSet{
            subscribe?(value)
        }
    }
    
    init(value:Element) {
        self.value = value
    }
}
