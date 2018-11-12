//
//  CoreDataPersistence.swift
//  SortRestaurant
//
//  Created by Haroon Ur Rasheed on 11/11/2018.
//  Copyright © 2018 Haroon Ur Rasheed. All rights reserved.
//

import CoreData

class CoreDataPersistence {
    
    //MARK: - init
    
    public var container : NSPersistentContainer
    init() {
        container = NSPersistentContainer(name: "Restaurant")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
    }
    
    //MARK: - perform methods
    
    public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(block)
    }
    
    public func performViewTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        block(container.viewContext)
    }
}
