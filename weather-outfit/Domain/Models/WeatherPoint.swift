//
//  WeatherPoint.swift
//  weather-outfit
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
