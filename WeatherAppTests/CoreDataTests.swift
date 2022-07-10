//
//  CoreDataTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 10/7/22.
//

import XCTest
import CoreData
@testable import WeatherApp

final class CoreDataTests: CoreDataService {

    
    init() {
        super.init(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, entityName: Constant.coreDataModel)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: Constant.coreDataModel)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
//        persistentContainer = container
    }
    
    
    
}
