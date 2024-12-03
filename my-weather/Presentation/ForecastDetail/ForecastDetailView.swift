//
//  ForecastDetailView.swift
//  my-weather
//
//  Created by Romain Roche on 27/11/2024.
//

import SwiftUI

struct ForecastDetailView: View {
      
    private let points: [WeatherPoint]
    
    init(with points: [WeatherPoint]) {
        self.points = points
    }
    
    var body: some View {
        Text("Hello World")
    }
    
}

#Preview {
    ForecastDetailView(with: WeatherPoint.mocks)
}

extension Date {
    
    func isSameDay(as other: Date) -> Bool {
        Calendar.current
            .isDate(
                self,
                equalTo: other,
                toGranularity: .day
            )
    }
    
}
