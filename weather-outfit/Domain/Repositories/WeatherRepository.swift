//
//  WeatherRepository.swift
//  weather-outfit
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

/// Handle weather forecast data.
public protocol WeatherRepository {
    /// Get locations based forecast.
    /// - Parameter latitude: The latitude.
    /// - Parameter longitude: The longitude.
    /// - Returns: An array of `WeatherPoint`.
    func getForecast(latitude: Double, longitude: Double) async throws -> [WeatherPoint]
}
