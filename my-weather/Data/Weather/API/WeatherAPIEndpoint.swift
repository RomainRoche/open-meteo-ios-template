//
//  WeatherAPIEndpoint.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

/// Allow to build URLs.
enum WeatherAPIEndpoint: String {
    case openMeteo = "https://api.open-meteo.com"
    
    enum Path: String {
        case forecast = "/v1/forecast"
    }
    
    enum Query {
        case coordinates(lat: Double, lon: Double)
        case hourly([QueryValues])
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .coordinates(let lat, let lon):
                [URLQueryItem(name: "latitude", value: String(format: "%.2f", lat)),
                 URLQueryItem(name: "longitude", value: String(format: "%.2f", lon))]
            case .hourly(let values):
                [URLQueryItem(name: "hourly", value: values.map(\.rawValue).joined(separator: ","))]
            }
        }
    }
    
    enum QueryValues: String {
        case temperature = "temperature_2m"
        case precipitation = "precipitation"
        case weatherCode = "weather_code"
        case windSpeed = "wind_speed_10m"
    }
    
    func url(for path: Path, query: [Query]? = nil) -> URL? {
        guard var components = URLComponents(string: rawValue) else { return nil }
        components.path = path.rawValue
        
        components.queryItems = []
        for query in query ?? [] {
            components.queryItems?.append(contentsOf: query.queryItems)
        }
        
        return components.url
    }
}
