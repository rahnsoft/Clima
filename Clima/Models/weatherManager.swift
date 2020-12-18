//
//  weatherManager.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 14/12/2020.
//

import Foundation
import CoreLocation
protocol weatherManagerDelegate {
    func didUpdateWeather(_ weathermanager: weatherManager ,weather: weatherModel)
    func didFailWithError(error: Error)
}
struct weatherManager {
    let weatherUrl: String = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=7a2d3fb47d3d5a2ab03fc9db29ff3819&"
    var delegate: weatherManagerDelegate?
    func fetchWeather(cityName: String){
        let urlString = "\(weatherUrl)q=\(cityName)"
        debugPrint(urlString)
        performRequest(with: urlString)
    }
    func fetchWeatherLatLon(lat:CLLocationDegrees ,lon: CLLocationDegrees){
        let urlString = "\(weatherUrl)lat=\(lat)&lon=\(lon)"
        debugPrint(urlString)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            task.resume()
        }
    }
    func parseJson(_ weatherData: Data) -> weatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(weatherAPi.self, from: weatherData)
            guard let weatherId = decodedData.weather[0]?.id else {return nil}
            guard let temp = decodedData.main?.temp else {return nil}
            guard let name = decodedData.name else {return nil}
            
            let weatherProps = weatherModel(conditionId: weatherId, temp: temp, cityName: name)
            return weatherProps
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}

