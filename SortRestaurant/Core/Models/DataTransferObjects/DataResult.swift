//
//  DataResult.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

typealias ResultHandler<T,E:Error> = ((DataResult<T,E>)->Void)

public enum DataResult<T,E:Error> {
    case success(T)
    case failure(E)
}
