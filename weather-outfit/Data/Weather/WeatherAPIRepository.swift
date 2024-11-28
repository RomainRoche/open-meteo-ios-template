//
//  WeatherAPIRepository.swift
//  weather-outfit
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

final class WeatherAPIRepository: WeatherRepository {
    
    func getForecast(latitude: Double, longitude: Double) async throws -> [WeatherPoint] {
        // Note: Call
        // `https://api.open-meteo.com/v1/forecast?latitude=48.86&longitude=2.35&hourly=precipitation,temperature_2m,weather_code,wind_speed_10m`
        // TODO: Implement this
        return []
    }
    
}
