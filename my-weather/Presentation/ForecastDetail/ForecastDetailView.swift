//
//  ForecastDetailView.swift
//  my-weather
//
//  Created by Romain Roche on 27/11/2024.
//

import SwiftUI

struct ForecastDetailView: View {
          
    private let averageTemperature: Double
    
    @StateObject
    private var viewModel: ForecastDetailViewModel
    
    init(with points: [WeatherPoint]) {
        let date = Date()
        
        self._viewModel = StateObject(
            wrappedValue: ForecastDetailViewModel(
                points: points.filter { $0.date.isSameDay(as: date) }
            )
        )
        
        self.averageTemperature = points.reduce(0, { partialResult, point in
            return partialResult + point.temperature
        }) / Double(points.count)
    }
    
    @ViewBuilder
    private func emojiList() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 16) {
                ForEach(Array(self.viewModel.points.enumerated()), id: \.offset) { point in
                    Text(point.element.weather.emoji)
                        .font(Font.system(size: 64))
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    var body: some View {
        VStack {
            emojiList()
                .padding(.bottom, 16)
            
            HStack {
                Text("Temp. moyenne:")
                Text("\(averageTemperature)")
            }
            
            Button {
                // action
                viewModel.filterPoints(whereCodeIs: .clear)
            } label: {
                // contenu
                Text("Filter")
                Image(systemName: "sun.min")
            }
            .padding(.top, 16)
            
            Spacer()
        }
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
