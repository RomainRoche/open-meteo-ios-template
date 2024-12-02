//
//  WeatherAPIOutput.swift
//  my-weather
//
//  Created by Romain Roche on 28/11/2024.
//


struct WeatherAPIOutput: Decodable {
    
    let hourly: Hourly
    
    enum CodingKeys: String, CodingKey {
        case hourly = "hourly"
    }
    
    struct Hourly: Decodable {
        let times: [String]
        let precipitation: [Double]
        let temperature: [Double]
        let weatherCode: [Int]
        let windSpeed: [Double]
        
        enum CodingKeys: String, CodingKey {
            case times = "time"
            case precipitation = "precipitation"
            case temperature = "temperature_2m"
            case weatherCode = "weather_code"
            case windSpeed = "wind_speed_10m"
        }
    }
    
}
