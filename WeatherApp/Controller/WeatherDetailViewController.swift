//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var weatherTxt: UILabel!
    @IBOutlet weak var weatherTempLbl: UILabel!
    
    var weatherCondition: CurrentCondition?
    var areaName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        title = areaName
        weatherImage.layer.cornerRadius = weatherImage.bounds.height / 2
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 38/255, green: 66/255, blue: 71/255, alpha: 1)]
        
        weatherTempLbl.text = "\(weatherCondition?.tempC ?? "") °C"
        weatherTxt.text = "Its a \(weatherCondition?.weatherDesc[0].value ?? "") day"
        humidityLbl.text = "Humidity: \(weatherCondition?.humidity ?? "")%"
        
        if let imageUrl = weatherCondition?.weatherIconURL[0].value {
            weatherImage.downloaded(from: URL(string: imageUrl)!)
        }
    }
    
}

