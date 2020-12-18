//
//  weatherModel.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 15/12/2020.
//

import Foundation
struct weatherModel {
    var conditionId: Int
    var temp: Double?
    var cityName: String?
    
    var tempString: String{
        return String(format: "%.1f", temp!)
    }
    
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
