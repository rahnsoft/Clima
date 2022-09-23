//
//  weatherManager.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 14/12/2020.
//

import CoreLocation
import Foundation
/// Protocal for the weather
protocol WeatherManagerDelegate {
    func didUpdateCurrentWeather(_ weathermanager: WeatherManager, weather: (WeatherModel, [ForecastWeatherModel]))
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl: String = Constants.forecastWeatherURl
    var delegate: WeatherManagerDelegate?

    /// fetch the weather by city name
    /// - Parameters :
    /// ` cityName ` : city name
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)q=\(cityName)"
        debugPrint(urlString)
        performRequest(with: urlString)
    }

    /// fetch the weather by coordinates
    /// - Parameters :
    /// ` lat ` : latitude
    /// ` lon ` : longitude
    func fetchWeatherLatLon(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let urlString = "\(weatherUrl)lat=\(lat)&lon=\(lon)"
        debugPrint(urlString)
        performRequest(with: urlString)
    }

    /// Perform the url session data task to get the data from the open weather api
    /// - Parameters :
    /// ` API Url ` :  The created open weather url
    ///  - Returns : ` Data `
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(safeData) {
                        self.delegate?.didUpdateCurrentWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    /// Decode the data and initalize the weatherModel
    /// - Parameters :
    /// ` weatherData ` :  The weather Data returned from the URL Session Task
    ///  - Returns : ` WeatherModel `  and ` ForecastWeatherModel `
    func parseJson(_ weatherData: Data) -> (WeatherModel, [ForecastWeatherModel])? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(_WeatherModel.self, from: weatherData)
            guard let weatherId = decodedData.list.first?.weather[0]?.id else { return nil }
            guard let temp = decodedData.list.first?.main?.temp else { return nil }
            let name = (decodedData.city?.name ?? "") + " , " + (decodedData.city?.country ?? "")

            let weatherProps = WeatherModel(conditionId: weatherId, temp: temp, cityName: name)
            return (weatherProps, decodedData.list)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
