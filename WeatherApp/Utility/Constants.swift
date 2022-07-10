//
//  Constants.swift
//  WeatherApp
//
//  Created by Ivan Loh on 9/7/22.
//

import Foundation

struct Constant {
    
    static let APIKEY = "3f0436212f204cebad615843220807"
    
    static let coreDataModel = "CityDataModel"
    static let coreDataModelMock = "CityDataModelMock"
    
    static func getCityURL(cityName: String) -> String {
        return "https://api.worldweatheronline.com/premium/v1/search.ashx?query=\(cityName)&num_of_results=5&format=json&key=\(Constant.APIKEY)"
    }
    
    static func getCityCondition(lat: String, long: String) -> String {
        return "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=\(Constant.APIKEY)&q=\(lat),\(long)&num_of_days=2&tp=3&format=json"
    }
}
