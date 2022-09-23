//
//  weatherModel.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 15/12/2020.
//

import Foundation
struct WeatherModel {
    var conditionId: Int
    var temp: Double?
    var cityName: String?
    
    ///  Round off the Temp fron Double to string using a floating point of 1 decimal place
    var tempString: String{
        return String(format: "%.1f", temp!)
    }
    
    /// Get the image of the weather condition
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "snow"
        case 800 :
            return "sun.min.fill"
        case 801...804:
            return "cloud.fill"
        case 701, 711:
            return "smoke.fill"
        case 721:
            return "sun.haze.fill"
        case 731, 761:
            return "sun.dust.fill"
        case 741, 751,771:
            return "cloud.fog.fill"
        case 781:
            return "tornado"
        default:
            return "cloud.fog.fill"
        }
    }
}
