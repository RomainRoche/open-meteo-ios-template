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
    
    private let weatherAPIRepository = WeatherAPIRepository()
    private let weatherDBRepository = WeatherDBRepository(
        persistentContainer: UIApplication.appDelegate.persistentContainer
    )
    
    private var weatherPoints: [WeatherPoint] = []
    
    /// Get the weather's forecasts.
    private func getForecasts() async {
        let latitude: Double = 48.86
        let longitude: Double = 2.35
        
        do {
            let weatherPoints = try await weatherAPIRepository.getForecast(
                latitude: latitude,
                longitude: longitude
            )
            self.weatherPoints = weatherPoints
            
            try? await self.weatherDBRepository.saveForecasts(
                weatherPoints,
                forLatitude: latitude,
                longitude: longitude
            )
            
            self.forecastsTableView.reloadData()
        } catch {
            let localPoints = try? await self.weatherDBRepository.getForecast(
                latitude: latitude,
                longitude: longitude
            )
            self.weatherPoints = localPoints ?? []
            self.forecastsTableView.reloadData()
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.refreshButton.setTitle("Refresh", for: .normal)
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
    
    // MARK: - Setup
    
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        forecastsTableView.dataSource = self
    }
    
    // MARK: - Button action
    
    @IBAction
    private func onRefresh(_ sender: UIButton) {
        Task {
            await self.getForecasts()
        }
    }

}

extension ForecastsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.weatherPoints.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ForecastTableViewCell",
            for: indexPath
        )
        
        switch cell {
        case let cell as ForecastTableViewCell:
            let point = weatherPoints[indexPath.row]
            cell.weatherEmojiLabel.text = point.weather.emoji
            cell.dateLabel.text = dateFormatter.string(from: point.date)
            cell.weatherNameLabel.text = point.weather.title
        default:
            break
        }
        
        return cell
    }
    
}
