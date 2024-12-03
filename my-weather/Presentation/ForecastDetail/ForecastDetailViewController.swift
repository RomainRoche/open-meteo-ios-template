//
//  ForecastDetailViewController.swift
//  my-weather
//
//  Created by Romain Roche on 27/11/2024.
//

import UIKit
import SwiftUI

class ForecastDetailViewController: UIHostingController<ForecastDetailView> {

    init(with points: [WeatherPoint]) {
        super.init(rootView: ForecastDetailView(with: points))
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
