//
//  WeatherAPIRepository.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import Foundation

final class WeatherAPIRepository: WeatherRepository {
    
    private enum Constants {
        static let filePath = "weather-forecasts.json"
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return dateFormatter
    }()
    
    /// Write some data
    /// - Parameter data: The data to write.
    /// - Parameter path: The path. Ex: `/some-folder/filename`
    /// - Throws: If writing fails.
    func write(data: Data, at path: String) throws {
        let url = URL.documentsDirectory.appending(path: path)
        try data.write(to: url)
    }

    /// Read some data
    /// - Parameter path: The path. Ex: `/some-folder/filename`
    /// - Throws: If reading fails.
    func getData(from path: String) throws -> Data {
        let url = URL.documentsDirectory.appending(path: path)
        return try Data(contentsOf: url)
    }
    
    private func pointFrom(output: WeatherAPIOutput) -> [WeatherPoint] {
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
    
    func getForecast(latitude: Double, longitude: Double) async throws -> [WeatherPoint] {
        do {
            let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=precipitation,temperature_2m,weather_code,wind_speed_10m")!
            
            let data = try await URLSession.shared.data(from: url).0
            let output = try JSONDecoder().decode(WeatherAPIOutput.self, from: data)
            
            do {
                try write(data: data, at: Constants.filePath)
            } catch {
                print("write file error: \(error)")
            }
            
            return pointFrom(output: output)
        } catch {
            
            // log error
            
            guard let data = try? getData(from: Constants.filePath) else {
                return []
            }
            guard let output = try? JSONDecoder().decode(WeatherAPIOutput.self, from: data) else {
                return []
            }
            return pointFrom(output: output)
        }
    }
    
}
