//
//  ForecastDetailViewController.swift
//  weather-outfit
//
//  Created by Romain Roche on 27/11/2024.
//

import UIKit
import SwiftUI

class ForecastDetailViewController: UIHostingController<ForecastDetailView> {

    init() {
        super.init(rootView: ForecastDetailView())
    }
    
    @MainActor @preconcurrency required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
