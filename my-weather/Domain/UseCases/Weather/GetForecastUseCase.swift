//
//  GetForecaseUseCase.swift
//  my-weather
//
//  Created by Romain Roche on 11/11/2024.
//

import Foundation

// MARK: - Protocol

public protocol GetForecastUseCase {
    /// The weather repository. Should never be accessed directly. Only visible to allow default implementations.
    var weatherRepository: WeatherRepository { get }
    
    /// Init.
    /// - Parameter weatherRepository: The weather repository.
    init(weatherRepository: WeatherRepository)
    
    /// Execute the use case.
    /// - Returns: An array of `WeatherPoint`.
    func execute(for coordinates: Coordinates) async -> Result<[WeatherPoint], Error>
}

// MARK: - Base implementation

final class GetForecast: GetForecastUseCase {
    
    let weatherRepository: any WeatherRepository
    
    init(weatherRepository: any WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func execute(for coordinates: Coordinates) async -> Result<[WeatherPoint], Error> {
        do {
            let points = try await weatherRepository.getForecast(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
            return .success(points)
        } catch {
            return .failure(error)
        }
    }
    
}

// TODO: Create implementation
