//
//  WeatherDetailViewControllerTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class WeatherViewControllerTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testWeatherViewController_WhenEnter_WeatherLabelIsEmpty() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        sut?.loadViewIfNeeded()
        
        XCTAssertEqual(sut?.searchTxtField.text, "", "Search text field was not empty when the viewcontroller initially loaded")
    }
    
    
}
