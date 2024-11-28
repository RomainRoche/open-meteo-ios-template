//
//  LocationRepository.swift
//  weather-outfit
//
//  Created by Romain Roche on 11/11/2024.
//

import Foundation

public enum LocationError: Error {
    case notAuthorized
    case unknownError(Error)
}

public typealias LocationCompletion = (Result<Coordinates, LocationError>) -> Void

public protocol LocationRepository {
    /// Fetch current user's location.
    /// - Returns: a `latitude` and `longitude` tuple.
    func fetchLocation(completion: @escaping LocationCompletion)
}
