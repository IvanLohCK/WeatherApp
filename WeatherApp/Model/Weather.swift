//
//  Weather.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

struct WeatherResponse: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let request: [Request]
    let currentCondition: [CurrentCondition]

    enum CodingKeys: String, CodingKey {
        case request
        case currentCondition = "current_condition"
    }
}

struct CurrentCondition: Codable {
    let observationTime, tempC, humidity: String
    let weatherIconURL, weatherDesc: [Weather]

    enum CodingKeys: String, CodingKey {
        case observationTime = "observation_time"
        case tempC = "temp_C"
        case weatherIconURL = "weatherIconUrl"
        case weatherDesc
        case humidity
    }
}

struct Weather: Codable {
    let value: String
}

struct Request: Codable {
    let type, query: String
}
