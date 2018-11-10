//
//  DataResponseModel.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 10/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

struct DataResponseModel<T,E:Error> {
    public let result: DataResult<T,E>
}
