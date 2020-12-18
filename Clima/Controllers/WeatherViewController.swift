//
//  ViewController.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 01/12/2020.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    var weathermanager = weatherManager()
    let locationManager = CLLocationManager()
    lazy var weatherView: WeatherView = {
        let h = WeatherView()
        h.searchBtn.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        h.locationBtn.addTarget(self, action: #selector(locationBtnPressed), for: .touchUpInside)
        h.locationText.delegate = self
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage =  UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        constraintsAll()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weathermanager.delegate = self
        //        weathermanager.fetchWeather(cityName: "Nairobi")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func constraintsAll(){
        view.addSubview(weatherView)
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            
        ])
    }
    @objc func searchBtnPressed(_ sender: UIButton){
        weatherView.locationText.endEditing(true)
    }
    @objc func locationBtnPressed(_ sender: UIButton){
        locationManager.requestLocation()
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherView.locationText.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city  = weatherView.locationText.text { //optional binding
            weathermanager.fetchWeather(cityName: city)
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if weatherView.locationText.text != "" {
            return true
        } else {
            weatherView.locationText.placeholder = "Wewe type"
            return false
        }
    }
}
extension WeatherViewController: weatherManagerDelegate, CLLocationManagerDelegate {
    func didFailWithError(error: Error) {
        debugPrint(error)
    }
    func didUpdateWeather(_ weathermanager: weatherManager, weather: weatherModel) {
        DispatchQueue.main.async { [self] in
            let largeImg = UIImage.SymbolConfiguration(scale: .large)
            weatherView.conditionImage.image = UIImage(systemName: weather.conditionName, withConfiguration: largeImg)
            let measurementFormatter = MeasurementFormatter()
            measurementFormatter.locale = Locale(identifier: "ki_ke")
            let measurement = Measurement(value: weather.temp!, unit: UnitTemperature.celsius)
            weatherView.temperatureLabel.text = measurementFormatter.string(from: measurement)
            weatherView.citylabel.text = weather.cityName
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchWeatherLatLon(lat: lat, lon: lon)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}
