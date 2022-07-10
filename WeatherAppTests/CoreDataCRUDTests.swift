//
//  CoreDataCRUDTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 10/7/22.
//

import XCTest
import CoreData
@testable import WeatherApp

final class CoreDataCRUDTests: XCTestCase {

    var coreDataStack: CoreDataService!
    
    override func setUp() {
        coreDataStack = CoreDataTests()
        
    }
    
    override func tearDown() {
        coreDataStack = nil
    }
    
    func testCoreDataService_WhenAddingNewCity_ShouldReturnTrue() {
        let newCity = coreDataStack.add(areaName: "Test City", region: "test", longitude: "12.123", latitude: "12.123")
        
        XCTAssertTrue(newCity.areaName == "Test City")
        XCTAssertTrue(newCity.region == "test")
        XCTAssertTrue(newCity.longitude == "12.123")
        XCTAssertTrue(newCity.latitude == "12.123")
        
        coreDataStack.delete(item: newCity)
        
    }
    
    func testCoreDataService_WhenGivenData_ShouldNotBeNil() {
        
        let newCity = coreDataStack.add(areaName: "Test City", region: "test", longitude: "12.123", latitude: "12.123")
        
        XCTAssertNotNil(newCity)
        coreDataStack.delete(item: newCity)
    }
    
    func testCoreDataService_WhenLoadingAllData_ShouldNotBeNil() {
        let newCity = coreDataStack.add(areaName: "Test City", region: "test", longitude: "12.123", latitude: "12.123")
        let allItems = coreDataStack.loadItems()
        
        XCTAssertNotNil(allItems)
        coreDataStack.delete(item: newCity)
    }
    
    func testCoreDataService_SortCitiesAlphabetically_ShouldBeTrue() {
        var cities = [CityDataModel]()
        
        let firstCity = coreDataStack.add(areaName: "zTest City", region: "test", longitude: "12.123", latitude: "12.123")
        let secondCity = coreDataStack.add(areaName: "aTest City", region: "test", longitude: "12.123", latitude: "12.123")
        cities.append(firstCity)
        cities.append(secondCity)
        
        let result = coreDataStack.sortCitiesAlphabetically(cities: cities)
        print(result[0])
        print(result[1])
        
        XCTAssertEqual(result[0], secondCity, "Array should be sorted alphabetically, secondCity should be in result[0]")
        XCTAssertEqual(result[1], firstCity, "Array should be sorted alphabetically, firstCity should be in result[1]")
        coreDataStack.delete(item: firstCity)
        coreDataStack.delete(item: secondCity)
    }
    
    func testCoreDataService_DeleteAllCities_ShouldBeTrue() {
        coreDataStack.add(areaName: "Test City", region: "test", longitude: "12.123", latitude: "12.123")
        let isDeleted = coreDataStack.deleteAll()
        
        XCTAssertTrue(isDeleted)
        
    }
}
