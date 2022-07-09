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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        weatherTempLbl.text = weatherCondition?.tempC
        weatherTxt.text = weatherCondition?.weatherDesc[0].value
        humidityLbl.text = weatherCondition?.humidity
        
        if let imageUrl = weatherCondition?.weatherIconURL[0].value {
            weatherImage.downloaded(from: URL(string: imageUrl)!)
        }
        
    }
    
}

