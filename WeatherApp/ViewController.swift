//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ivan Loh on 8/7/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var cities: [City] = []
    var viewedCity = [CityDataModel]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchTxtField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadItems()
        tableView.reloadData()
    }
    
    private func loadItems() {
        let request: NSFetchRequest<CityDataModel> = CityDataModel.fetchRequest()
        do {
            viewedCity = try context.fetch(request)
            viewedCity = viewedCity.suffix(10)
            viewedCity = viewedCity.sorted {$0.areaName! < $1.areaName!}
        } catch {
            print("error fetching data from context: \(error)")
        }
       
    }
    
    private func saveItem() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let newFrame = (notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey ] as? NSValue)?.cgRectValue {

                var insets: UIEdgeInsets

                if tableView.contentInset.bottom == 0 {
                    insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
                } else {
                    insets = UIEdgeInsets( top: 0, left: 0, bottom: 0, right: 0 )
                }

                tableView.contentInset = insets
                tableView.scrollIndicatorInsets = insets
            }
       }

      @objc func keyboardWillHide(notification: Notification) {
          tableView.contentInset = .zero
      }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewedCity.count
        } else {
            return cities.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return viewedCity.isEmpty ? "You have not viewed any City yet" : "Recently Viewed"
        } else {
            return "Search Result:"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListViewCell", for: indexPath) as! WeatherListViewCell
        
        if indexPath.section == 0 {

            let areaName = viewedCity[indexPath.row].areaName
            let regionName = viewedCity[indexPath.row].region

            cell.areaNameTxt.text = areaName
            cell.regionNameTxt.text = regionName

        } else {
            let areaName = cities[indexPath.row].areaName[0]
            let regionName = cities[indexPath.row].region[0]

            cell.areaNameTxt.text = areaName.value
            cell.regionNameTxt.text = regionName.value
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && !viewedCity.contains(where: {$0.latitude == cities[indexPath.row].latitude}) && !viewedCity.contains(where: {$0.longitude == cities[indexPath.row].longitude}) {
            
            let storeCity = CityDataModel(context: context)
            storeCity.areaName = cities[indexPath.row].areaName[0].value
            storeCity.region = cities[indexPath.row].region[0].value
            storeCity.longitude = cities[indexPath.row].longitude
            storeCity.latitude = cities[indexPath.row].latitude
            
            saveItem()
            
        }
        
        var long = ""
        var lat = ""
        
        if indexPath.section == 0 {
            long = viewedCity[indexPath.row].longitude!
            lat = viewedCity[indexPath.row].latitude!
        } else {
            long = cities[indexPath.row].longitude
            lat = cities[indexPath.row].latitude
        }
        
        
        
        WeatherService().getConditions(lat: lat, long: long) { temperatures in
            
            if let temperature = temperatures {
                DispatchQueue.main.async {
                    let time = temperature[0].observationTime
                    let temp = temperature[0].tempC
                    let humidity = temperature[0].humidity
                    let weatherDesc = temperature[0].weatherDesc[0]
                    let imageUrl = temperature[0].weatherIconURL[0]
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController
                    vc?.weatherCondition = CurrentCondition(observationTime: time, tempC: temp, humidity: humidity, weatherIconURL: [imageUrl], weatherDesc: [weatherDesc])
                    
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 0{
            context.delete(viewedCity[indexPath.row])
            viewedCity.remove(at: indexPath.row)
            saveItem()
            loadItems()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else {
            return false
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = textField.text {
            WeatherService().getCities(cityName: cityName) { results in

                if let results = results {
                    DispatchQueue.main.async {
                        self.cities = results
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
        return true
    }
}
