//
//  CurrentWeatherData.swift
//  WeatherAPI
//
//  Created by Mikhail on 20.03.2021.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
struct Weather: Codable {
    let id: Int
}
