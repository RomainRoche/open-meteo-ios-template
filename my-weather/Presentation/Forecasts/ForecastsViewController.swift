//
//  ViewController.swift
//  my-weather
//
//  Created by Romain Roche on 10/11/2024.
//

import UIKit
import Swinject

final class ForecastsViewController: UIViewController {

    // MARK: - UI Properties
    
    @IBOutlet private var refreshButton: UIButton!
    @IBOutlet private var forecastsTableView: UITableView!
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "eee dd MMM, hh:mm a"
        return formatter
    }()
    
    // MARK: - Forecasts management
    
    private var container: Container {
        (UIApplication.shared.delegate as? AppDelegate)?.container ?? Container()
    }
    
    /// The use case for location
    private lazy var getLocation: GetLocationUseCase = {
        container.resolve(GetLocationUseCase.self)!
    }()
    
    /// The use case to use to fetch forecasts data.
    private lazy var getForecast: GetForecastUseCase = {
        container.resolve(GetForecastUseCase.self)!
    }()
        
    private var weatherPoints: [WeatherPoint] = []
        
    /// Get the weather's forecasts.
    private func getForecasts() async {
        do {
            // .get(): returns result if Result is a success, otherwise throw error
            let coordinates = try await getLocation.execute().get()
            
            let weatherPoints = try await getForecast.execute(for: coordinates).get()
            self.weatherPoints = weatherPoints
            self.forecastsTableView.reloadData()
        } catch {
            print(error)
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
        Task {
            await getForecasts()
        }
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
        forecastsTableView.delegate = self
    }
    
    // MARK: - Button action
    
    @IBAction
    private func onRefresh(_ sender: UIButton) {
        Task {
            await self.getForecasts()
        }
    }

}

extension ForecastsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ForecastDetailViewController(with: weatherPoints)
        self.navigationController?.pushViewController(viewController, animated: true)
        print(indexPath.row)
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
