//
//  WeatherPoint.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

/// Weather data at a specific point.
public struct WeatherPoint {
    /// The date.
    public let date: Date
    /// The C° temperature
    public let temperature: Double
    /// The mm precipitations
    public let precipitation: Double
    /// The wind speed km/h
    public let windSpeed: Double
    /// The weather type.
    public let weather: WeatherCode
}

public extension WeatherPoint {
    
    static var mocks: [Self] {
        (0...99).map { idx in
            WeatherPoint(
                date: Date().addingTimeInterval(60*Double(idx)),
                temperature: .random(in: -3...24),
                precipitation: .random(in: 0...20),
                windSpeed: .random(in: 0...12),
                weather: WeatherCode(rawValue: Int.random(in: -1...99)) ?? .clear
            )
        }
    }
    
}
