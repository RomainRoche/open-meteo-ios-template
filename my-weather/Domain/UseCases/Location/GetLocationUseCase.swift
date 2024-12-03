//
//  GetLocationUseCase.swift
//  my-weather
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

final class GetLocation: GetLocationUseCase {
    let locationRepository: LocationRepository
    
    init(locationRepository: any LocationRepository) {
        self.locationRepository = locationRepository
    }
    
    func execute() async -> Result<Coordinates, LocationError> {
        return await withCheckedContinuation { continuation in
            locationRepository.fetchLocation { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    
    
    
}

// TODO: Create implementation
