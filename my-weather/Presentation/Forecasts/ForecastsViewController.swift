//
//  ViewController.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import UIKit

final class ForecastsViewController: UIViewController {

    // MARK: - UI Properties
    
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var forecastsTableView: UITableView!
    
    private var weatherItems: [WeatherUIItem] = []
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "eee dd MMM, hh:mm a"
        return formatter
    }()
    
    // MARK: - Forecasts management
    
    /// The use case for location
//    private let getLocation: GetLocationUseCase // TODO: Implement this
    
    /// The use case to use to fetch forecasts data.
//    private let getForecast: GetForecastUseCase // TODO: Implement this
    
    /// Get the weather's forecasts.
    private func getForecasts() async {
        // TODO: Implement this
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Button action
    
    @IBAction
    private func onRefresh(_ sender: UIButton) {
        Task {
            await self.getForecasts()
        }
    }

}
