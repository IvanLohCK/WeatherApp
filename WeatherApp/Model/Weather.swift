//
//  Weather.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let request: [Request]
    let currentCondition: [CurrentCondition]

    enum CodingKeys: String, CodingKey {
        case request
        case currentCondition = "current_condition"
    }
}

// MARK: - CurrentCondition
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

// MARK: - Weather
struct Weather: Codable {
    let value: String
}

// MARK: - Request
struct Request: Codable {
    let type, query: String
}
