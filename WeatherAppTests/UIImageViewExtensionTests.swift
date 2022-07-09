//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ivan Loh on 9/7/22.
//

import XCTest
@testable import WeatherApp

final class UIImageViewExtensionTests: XCTestCase {

    var sut: UIImageView!
    let imageUrl = "http://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }

    
    func testUIImageView_WhenGivenSuccessfullResponse_ReturnSuccess() {
        
        sut = UIImageView()
        
        sut.downloaded(from: imageUrl)
        
        
        
    }
    
    
    
    

}
