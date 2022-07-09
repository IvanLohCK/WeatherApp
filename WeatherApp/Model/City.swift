//
//  Weather.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

struct CityResponse: Codable {
    let searchAPI: SearchAPI

    enum CodingKeys: String, CodingKey {
        case searchAPI = "search_api"
    }
}

struct SearchAPI: Codable {
    let result: [City]
}

struct City: Codable {
    let areaName, region: [AreaName]
    let latitude, longitude: String
}

struct AreaName: Codable {
    let value: String
}

