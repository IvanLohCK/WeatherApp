//
//  SearchCityWebServiceTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class SearchCityWebServiceTests: XCTestCase {

    var sut: WeatherService!
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        sut = nil
    }

    func testSearchCityWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        let cityName = "London"
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/search.ashx?query=\(cityName)&num_of_results=3&format=json&key=3f0436212f204cebad615843220807")
        
        let expectation = self.expectation(description: "Search City Response expectation")
        
        sut.getCities() { cities, err in
            
            if let areaName = cities![0].areaName {
                
                XCTAssertEqual(cityName, areaName[0].value)
                expectation.fulfill()
            }
            
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchCityWebService_WhenURLGivenIsNil_ErrorTookPlace() {
       
        sut = WeatherService(urlString: "")

        let expectation = self.expectation(description: "Expecting the URL is nil")

        sut.getCities() { cities, err in

            XCTAssertNil(cities, "Given that the URL is empty, the result should have been nil")
            expectation.fulfill()

        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchCityWebService_WhenReceiveDifferentJSONResposne_ErrorTookPlace() {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{:}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/search.ashx?query=London&num_of_results=3&format=json&key=3f0436212f204cebad615843220807", urlSession: urlSession)

        let expectation = self.expectation(description: "Expacting for a response that contains different JSON structure")

        sut.getCities() { cities, err in

            XCTAssertNil(cities, "The response model containing unknown JSON response, should have been nil")
            expectation.fulfill()

        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSearchCityWebService_WhenURLRequestFails_ErrorTookPlace() {
        
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDesc = "A localized description of an error"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/search.ashx?query=London&num_of_results=3&format=json&key=3f0436212f204cebad615843220807", urlSession: urlSession)
        
        MockURLProtocol.error = WeatherServiceError.failedRequest(description: errorDesc)
        
        sut.getCities() { cities, err in
            
            XCTAssertEqual(err, WeatherServiceError.failedRequest(description: errorDesc))
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
}
