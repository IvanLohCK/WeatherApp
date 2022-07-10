//
//  WeatherDetailViewControllerTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class WeatherViewControllerTests: XCTestCase {
    
    func makeSUT() -> WeatherViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as! WeatherViewController
        sut.loadViewIfNeeded()
        return sut
    }
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testWeatherViewController_WhenEnterWeatherVC_WeatherLabelIsEmpty() {
        
       let sut = makeSUT()
        
        XCTAssertEqual(sut.searchTxtField.text, "", "Search text field was not empty when the viewcontroller initially loaded")
    }
    
    func testWeatherViewController_WhenEnterWeatherVC_TableViewIsNotEmpty() {
        
       let sut = makeSUT()
        
        XCTAssertNotNil(sut.tableView)
    }
    
}
