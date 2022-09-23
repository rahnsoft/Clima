//
//  ForecastWeatherModel.swift
//  Clima
//
//  Created by Nicholas Wakaba on 07/09/2022.
//

import Foundation
import UIKit

struct _WeatherModel: Decodable{
    var list: [ForecastWeatherModel]
    var city: City?
}

struct ForecastWeatherModel: Decodable {
    var dt_txt: String?
    var weather: [Weather?]
    var main: Main?

}

struct City: Decodable {
    var name: String?
    var country: String?
}
