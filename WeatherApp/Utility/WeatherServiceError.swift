//
//  WeatherServiceError.swift
//  WeatherApp
//
//  Created by Ivan Loh on 9/7/22.
//

import Foundation

enum WeatherServiceError: Error, Equatable {
    
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    
}
