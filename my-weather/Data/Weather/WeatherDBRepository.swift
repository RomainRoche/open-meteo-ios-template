//
//  WeatherDBRepository.swift
//  my-weather
//
//  Created by Romain Roche on 02/12/2024.
//

import Foundation
import CoreData

final class WeatherDBRepository: WeatherRepository {
    
    private let persistentContainer: NSPersistentContainer
    
    init (persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getForecast(
        latitude: Double,
        longitude: Double
    ) async throws -> [WeatherPoint] {
        let request = LocalWeatherPoint.fetchRequest()
        request.predicate = NSPredicate(format: "latitude == %lf AND longitude == %lf", latitude, longitude)
        
        let dbPoints = try persistentContainer.viewContext.fetch(request)
        return dbPoints.map {
            WeatherPoint(
                date: $0.date,
                temperature: $0.temperature,
                precipitation: $0.precipitation,
                windSpeed: $0.windSpeed,
                weather: WeatherCode(rawValue: Int($0.weatherCode)) ?? .unknown
            )
        }
    }
    
    private func deleteExisting(
        forecasts: [WeatherPoint],
        forLatitude latitude: Double,
        longitude: Double
    ) async throws {
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                do {
                    for forecast in forecasts {
                        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "LocalWeatherPoint")
                        request.predicate = NSPredicate(
                            format: "latitude == %lf AND longitude == %lf AND date == %@",
                            latitude,
                            longitude,
                            forecast.date.beginningOfHour() as NSDate
                        )
                        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                        try self.persistentContainer.viewContext.execute(deleteRequest)
                    }
                    try self.persistentContainer.saveContext()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func saveForecasts(
        _ forecasts: [WeatherPoint],
        forLatitude latitude: Double,
        longitude: Double
    ) async throws {
        try await deleteExisting(forecasts: forecasts, forLatitude: latitude, longitude: longitude)
        
        try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async {
                do {
                    forecasts.forEach {
                        let point = LocalWeatherPoint(context: self.persistentContainer.viewContext)
                        point.date = $0.date.beginningOfHour()
                        point.temperature = $0.temperature
                        point.precipitation = $0.precipitation
                        point.windSpeed = $0.windSpeed
                        point.weatherCode = Int16($0.weather.rawValue)
                        point.latitude = latitude
                        point.longitude = longitude
                    }
                    try self.persistentContainer.saveContext()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}

extension Date {
    func beginningOfHour() -> Date {
        let components = Calendar.current.dateComponents(
            [
                .year,
                .month,
                .day,
                .hour
            ],
            from: self
        )
        guard let date = Calendar.current.date(from: components) else { return self }
        return date
    }
}
