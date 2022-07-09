//
//  WebServices.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

struct WeatherService {
    
    func getCities(cityName: String, completion: @escaping([City]?) -> Void) {
        guard let url = URL(string: "https://api.worldweatheronline.com/premium/v1/search.ashx?query=\(cityName)&num_of_results=3&format=json&key=3f0436212f204cebad615843220807") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else {
                completion(nil)
                return
            }
            
            let cityResponse = try? JSONDecoder().decode(CityResponse.self, from: data)
            
            
            if let cityResponse = cityResponse {
                let city = cityResponse.searchAPI.result
                
                completion(city)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    func getConditions(lat: String, long: String, completion: @escaping([CurrentCondition]?) -> Void) {
        guard let url = URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx?key=3f0436212f204cebad615843220807&q=\(lat),\(long)&num_of_days=2&tp=3&format=json") else {
            completion(nil)
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data, err == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let weatherResponse = weatherResponse {
                let weather = weatherResponse.data.currentCondition
                
                completion(weather)
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    

    
}
