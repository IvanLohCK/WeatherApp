//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Ivan Loh on 9/7/22.
//

import UIKit
import CoreData

class CoreDataService {
    
    let context: NSManagedObjectContext
    let entityName: String
    var viewedCity = [CityDataModel]()
    
    init(context: NSManagedObjectContext, entityName: String) {
        self.context = context
        self.entityName = entityName
    }
    
    private func saveItem() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
    }
    
    @discardableResult
    func add(areaName: String, region: String, longitude: String, latitude: String) -> CityDataModel {
        let storeCity = CityDataModel(context: context)
        storeCity.areaName = areaName
        storeCity.region = region
        storeCity.longitude = longitude
        storeCity.latitude = latitude

        saveItem()
      return storeCity
    }
    
    
    func delete(item: CityDataModel) {
        context.delete(item)
        saveItem()
    }
    
    @discardableResult
    func deleteAll() -> Bool{
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveItem()
            return true
        } catch let error as NSError {
            print("error deleting context \(error)")
        }
        return false
    }
    
    func loadItems() -> [CityDataModel] {
        let request: NSFetchRequest<CityDataModel> = CityDataModel.fetchRequest()
        do {
            viewedCity = try context.fetch(request)
            viewedCity = sortCitiesAlphabetically(cities: viewedCity)
            viewedCity = viewedCity.suffix(10)
            
        } catch {
            print("error fetching data from context: \(error)")
        }
       
        return viewedCity
    }
    
    func sortCitiesAlphabetically(cities: [CityDataModel]) -> [CityDataModel] {
        return cities.sorted {$0.areaName! < $1.areaName!}
    }
    
}
