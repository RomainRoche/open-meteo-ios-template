//
//  WeatherAPIRepository.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

final class WeatherAPIRepository: WeatherRepository {
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm"
        return dateFormatter
    }()
    
    func getForecast(latitude: Double, longitude: Double) async throws -> [WeatherPoint] {
        
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=precipitation,temperature_2m,weather_code,wind_speed_10m")!
        
        let data = try await URLSession.shared.data(from: url).0
//        print(String(data: data, encoding: .utf8) ?? "")
        let output = try JSONDecoder().decode(WeatherAPIOutput.self, from: data)
        
        var results: [WeatherPoint] = []
        for i in 0..<output.hourly.times.count {
            let point = WeatherPoint(
                date: dateFormatter.date(from: output.hourly.times[i]) ?? Date(),
                temperature: output.hourly.temperature[i],
                precipitation: output.hourly.precipitation[i],
                windSpeed: output.hourly.windSpeed[i],
                weather: WeatherCode(rawValue: output.hourly.weatherCode[i]) ?? .unknown
            )
            results.append(point)
        }
        
        return results
    }
    
}
