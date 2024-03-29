//
//  weatherApi.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 14/12/2020.
//

import Foundation
struct CurrentWeatherAPIModel: Decodable {
    var name: String?
    var main: Main?
    var weather: [Weather?]
}

struct Main: Decodable {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct Weather: Decodable {
    var description: String?
    var id: Int?
}
