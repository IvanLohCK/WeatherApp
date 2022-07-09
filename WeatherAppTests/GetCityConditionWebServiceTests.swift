//
//  GetCityConditionWebServiceTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class GetCityConditionWebServiceTests: XCTestCase {

    var sut: WeatherService!
    var lat = "42.983"
    var long = "-81.250"
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        sut = nil
    }

    func testGetCityConditionWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=3f0436212f204cebad615843220807&q=\(lat),\(long)&num_of_days=2&tp=3&format=json")
        
        let expectation = self.expectation(description: "Get City Condition expectation")
        
        sut.getConditions() { weather, err in
            
            XCTAssertNotNil(weather)
            expectation.fulfill()
            
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetCityConditionWebService_WhenURLGivenIsNil_ErrorTookPlace() {
       
        sut = WeatherService(urlString: "")

        let expectation = self.expectation(description: "Expecting the URL is nil")

        sut.getConditions() { weather, err in

            XCTAssertNil(weather, "Given that the URL is empty, the result should have been nil")
            expectation.fulfill()

        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetCityConditionWebService_WhenReceiveDifferentJSONResposne_ErrorTookPlace() {
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{:}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=3f0436212f204cebad615843220807&q=\(lat),\(long)&num_of_days=2&tp=3&format=json", urlSession: urlSession)

        let expectation = self.expectation(description: "Expacting for a response that contains different JSON structure")

        sut.getConditions() { weather, err in

            XCTAssertNil(weather, "The response model containing unknown JSON response, should have been nil")
            expectation.fulfill()

        }
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testGetCityConditionWebService_WhenURLRequestFails_ErrorTookPlace() {
        
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDesc = "A localized description of an error"
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = WeatherService(urlString: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=3f0436212f204cebad615843220807&q=\(lat),\(long)&num_of_days=2&tp=3&format=json", urlSession: urlSession)
        
        MockURLProtocol.error = WeatherServiceError.failedRequest(description: errorDesc)
        
        sut.getConditions() { cities, err in
            
            XCTAssertEqual(err, WeatherServiceError.failedRequest(description: errorDesc))
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }

}
