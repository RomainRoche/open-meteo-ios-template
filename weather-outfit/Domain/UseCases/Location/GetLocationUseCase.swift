//
//  GetLocationUseCase.swift
//  weather-outfit
//
//  Created by Romain Roche on 26/11/2024.
//

import Foundation

// MARK: - Protocol

public protocol GetLocationUseCase {
    /// The weather repository. Should never be accessed directly. Only visible to allow default implementations.
    var locationRepository: LocationRepository { get }
    
    /// Init.
    /// - Parameter weatherRepository: The weather repository.
    init(locationRepository: LocationRepository)
    
    /// Execute the use case.
    /// - Returns: An array of `WeatherPoint`.
    func execute() async -> Result<Coordinates, LocationError>
}

// MARK: - Base implementation

// TODO: Create implementation
