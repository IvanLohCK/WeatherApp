//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import Foundation

class WeatherListViewModel {
    private var weatherViewModels = [WeatherViewModel]()
    
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
}

class WeatherViewModel {
    let weather: WeatherResponse
    
    init(weather: WeatherResponse) {
        self.weather = weather
    }
    
    var temp: String {
        return weather.data.currentCondition[0].tempC
    }
}

class CityListViewModel {
    private var cityViewModels = [CityViewModel]()
    
    func numberOfRows(_ section: Int) -> Int {
        return cityViewModels.count
    }
    
    func modelAt(_ index: Int) -> CityViewModel {
        return cityViewModels[index]
    }
    
}

class CityViewModel {
    let city: CityResponse
    
    init(city: CityResponse) {
        self.city = city
    }
    
    var areaName: String {
        city.searchAPI.result[0].areaName[0].value
    }
    
    var region: String {
        city.searchAPI.result[0].region[0].value
    }
    
    var longitude: String {
        city.searchAPI.result[0].longitude
    }
    
    var latitude: String {
        city.searchAPI.result[0].latitude
    }
}
