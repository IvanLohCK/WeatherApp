//
//  CoreDataService.swift
//  WeatherApp
//
//  Created by Ivan Loh on 9/7/22.
//

import UIKit
import CoreData

class CoreDataService {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewedCity = [CityDataModel]()
    
    func saveItem() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
    }
    
    func deleteItem(indexPath: IndexPath, viewedCity: [CityDataModel]) {
        context.delete(viewedCity[indexPath.row])
    }
    
    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CityDataModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            saveItem()
        } catch let error as NSError {
            print("error deleting context \(error)")
        }
    }
    
    func loadItems() -> [CityDataModel] {
        let request: NSFetchRequest<CityDataModel> = CityDataModel.fetchRequest()
        do {
            viewedCity = try context.fetch(request)
            viewedCity = viewedCity.sorted {$0.areaName! < $1.areaName!}
            viewedCity = viewedCity.suffix(10)
            
        } catch {
            print("error fetching data from context: \(error)")
        }
       
        return viewedCity
    }
    
}
