//
//  WeatherDetailViewController.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class WeatherDetailViewControllerTests: XCTestCase {

    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testWeatherViewController_WhenEnter_WeatherLabelIsEmpty() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? WeatherViewController
        sut?.loadViewIfNeeded()
        
        XCTAssertEqual(sut?.searchTxtField.text, "", "Search text field was not empty when the viewcontroller initially loaded")
    }
    
    func testWeatherDetailViewController_WhenEnter_WeatherLabelIsInDefaultValue() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController
        sut?.loadViewIfNeeded()
        
        XCTAssertEqual(sut?.weatherTempLbl.text, " °C")
        XCTAssertEqual(sut?.weatherImage.image, nil)
        XCTAssertEqual(sut?.weatherTxt.text, "Its a  day")
        XCTAssertEqual(sut?.humidityLbl.text, "Humidity: %")
    }
}
