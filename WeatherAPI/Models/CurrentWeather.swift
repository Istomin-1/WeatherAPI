//
//  CurrentWeather.swift
//  WeatherAPI
//
//  Created by Mikhail on 20.03.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let conditionCode: Int
    var systemIcnNameString: String {
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return
            "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return
            "cloud.fog.fill"
        case 800: return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default:
            return "questionmark.circle.fill"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temperature
        conditionCode = currentWeatherData.weather.first!.id
    }
}
