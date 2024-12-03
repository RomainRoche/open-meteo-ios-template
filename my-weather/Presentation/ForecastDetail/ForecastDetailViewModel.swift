//
//  ForecastDetailViewModel.swift
//  my-weather
//
//  Created by Romain Roche on 03/12/2024.
//
import SwiftUI

final class ForecastDetailViewModel: ObservableObject {
    
    @Published
    var points: [WeatherPoint]
    
    init(points: [WeatherPoint]) {
        self.points = points
    }
    
    func filterPoints(whereCodeIs weatherCode: WeatherCode) {
        points = points.filter { $0.weather == weatherCode }
    }
    
}
