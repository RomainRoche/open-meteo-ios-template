//
//  CoreLocationRepository.swift
//  weather-outfit
//
//  Created by Romain Roche on 26/11/2024.
//

import Foundation
import CoreLocation

final class CoreLocationRepository: NSObject, LocationRepository {
    
    private let manager = CLLocationManager()
    private var onLocationUpdate: LocationCompletion?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func fetchLocation(completion: @escaping LocationCompletion) {
        self.onLocationUpdate = completion
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            self.onLocationUpdate?(.failure(.notAuthorized))
            self.onLocationUpdate = nil
        }
        
    }
    
}

extension CoreLocationRepository: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        default:
            self.onLocationUpdate?(.failure(.notAuthorized))
            self.onLocationUpdate = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let coords = Coordinates(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        self.onLocationUpdate?(.success(coords))
        self.onLocationUpdate = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        self.onLocationUpdate?(.failure(.unknownError(error)))
        self.onLocationUpdate = nil
    }
    
}
