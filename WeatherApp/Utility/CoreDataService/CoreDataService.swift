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
    
    func loadItems() -> [CityDataModel] {
        let request: NSFetchRequest<CityDataModel> = CityDataModel.fetchRequest()
        do {
            viewedCity = try context.fetch(request)
            viewedCity = viewedCity.suffix(10)
            viewedCity = viewedCity.sorted {$0.areaName! < $1.areaName!}
        } catch {
            print("error fetching data from context: \(error)")
        }
       
        return viewedCity
    }
    
}
