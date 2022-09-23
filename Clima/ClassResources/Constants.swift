//
//  Constants.swift
//  Clima
//
//  Created by Nicholas Wakaba on 07/09/2022.
//

import Foundation
import UIKit

class Constants: NSObject {
    static let shared = Constants()

    static let default_padding: CGFloat = 8.0
    static let default_double_padding: CGFloat = 16.0

    static let default_font_size: CGFloat = 14.0
    static let default_large_font_size: CGFloat = 16.0
    static let default_extra_large_font_size: CGFloat = 18.0

    // TODO: - Save Api keys in keychain for security concerns
    /// Get the Api key from info plist file
    static var OpenWeatherAPIKey: String {
        return (Bundle.main.infoDictionary?["OpenWeatherAPIKey"] as? String)!
    }

    /// Construct the different open weather API's
    static let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=\(OpenWeatherAPIKey)&"
    static let forecastWeatherURl = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=\(OpenWeatherAPIKey)&"
}
