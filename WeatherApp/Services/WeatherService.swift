//
//  WebServices.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

struct WeatherService {
    
    private var urlString: String
    private var urlSession: URLSession
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func getCities(completion: @escaping([City]?, WeatherServiceError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, WeatherServiceError.invalidRequestURLString)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else {
                completion(nil, WeatherServiceError.failedRequest(description: Constant.localizedErrorDesc))
                return
            }
            
            let cityResponse = try? JSONDecoder().decode(CityResponse.self, from: data)
            
            if let cityResponse = cityResponse {
                let city = cityResponse.searchAPI.result
                completion(city, nil)
            } else {
                completion(nil, WeatherServiceError.invalidResponseModel)
            }
            
        }.resume()
    }
    
    func getConditions(completion: @escaping([CurrentCondition]?, WeatherServiceError?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, WeatherServiceError.invalidRequestURLString)
            return
        }
        
        urlSession.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else {
                completion(nil, WeatherServiceError.failedRequest(description: Constant.localizedErrorDesc))
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let weather = weatherResponse.data.currentCondition
                
                completion(weather, nil)
            } else {
                completion(nil, WeatherServiceError.invalidResponseModel)
            }
            
        }.resume()
        
    }
    
}
