//
//  NetworkWeatherManager.swift
//  WeatherAPI
//
//  Created by Mikhail on 20.03.2021.
//

import Foundation
import CoreLocation

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
            
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    private func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let currentWeather = self.parseJJSON(withData: data) {
                        self.onCompletion?(currentWeather)
                    }
                }
            }
            task.resume()
        }
    
    private func parseJJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let erorr as NSError {
            print(erorr.localizedDescription)
        }
        return nil
    }
}
