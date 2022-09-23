//
//  ViewController.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 01/12/2020.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {
    var weathermanager = WeatherManager()
    let locationManager = CLLocationManager()
    var temperature: Double?
    var cityText: String?
    var weatherImageName: String?
    var forecastWeather: [ForecastWeatherModel]?
    var sortedGroupedWeather: [(key: String, value: [ForecastWeatherModel])]?
    var weatherModelList: [WeatherModel]?
    var activityIndicator: UIActivityIndicatorView!

    /// Background Image
    var backgroundImage = UIImage(named: "sea_sunnypng")

    /// Background view color
    var backgroundViewColor: UIColor = .sunnyColor

    /// Create the tableView
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.tintColor = .label
        tv.rowHeight = UITableView.automaticDimension
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        return tv
    }()

    /// Create the search Controller
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "txt_enter_location".localize(), attributes: [.foregroundColor: UIColor.label])
        searchController.searchBar.barTintColor = .label
        searchController.searchBar.tintColor = .label
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchBarStyle = .prominent
        searchController.delegate = self
        return searchController
    }()

    /// Setup the views
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImageView = UIImageView()
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false

        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundViewColor
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(backgroundImageView, at: 0)
        view.insertSubview(backgroundView, at: 1)
        view.addSubview(tableView)

        title = "txt_weather".localize()

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        navigationItem.rightBarButtonItem = createLocationButton()
        navigationItem.rightBarButtonItem?.tintColor = .label

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weathermanager.delegate = self

        tableView.register(WeatherForeCastCell.self, forCellReuseIdentifier: WeatherForeCastCell.identifier)
        tableView.register(WeatherViewHeaderCell.self, forHeaderFooterViewReuseIdentifier: WeatherViewHeaderCell.identifier)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor),

            backgroundView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Constants.default_padding),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: Constants.default_padding),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -Constants.default_padding),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -Constants.default_padding)

        ])

        activityIndicator = UIActivityIndicatorView()
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }

    /// Create the right barButton item and add an action to it

    func createLocationButton() -> UIBarButtonItem {
        return UIBarButtonItem(image: .init(
            systemName: "location.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 17)
        ), style: .plain, target: self, action: #selector(locationBtnPressed))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .label
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.sizeToFit()
    }

    /// Action to be performed when location button is pressed
    @objc func locationBtnPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        locationManager.requestLocation()
    }

    /// Group the forecast weather to a dictionary whose key is the date
    func groupByDay(_ forecastWeather: [ForecastWeatherModel]) {
        if forecastWeather.count != .zero {
            let groupedWeather = Dictionary(grouping: forecastWeather, by: { Date.formatDate(from: Date.stringToDate(dateString: $0.dt_txt!)) })
            sortedGroupedWeather = groupedWeather.sorted(by: { $0.key < $1.key })
        }
    }
}

// MARK: - Delegate methods for table view

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (sortedGroupedWeather?.count ?? 0)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = section
        let sectionRows = sortedGroupedWeather?[sections].value.count
        return (sectionRows ?? 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForeCastCell.identifier, for: indexPath) as? WeatherForeCastCell ?? WeatherForeCastCell()
        let forecast = sortedGroupedWeather?[indexPath.section].value[indexPath.row]
        cell.dataSourceItem = WeatherModel(conditionId: (forecast?.weather[0]?.id)!, temp: (indexPath.row == .zero && indexPath.section == .zero) ? forecast?.main?.temp_min : forecast?.main?.temp, cityName: (indexPath.row == .zero && indexPath.section == .zero) ? String(format: "%.1f" + "\u{00B0}C", (forecast?.main?.temp_max)!) : forecast?.dt_txt)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == .zero {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherViewHeaderCell.identifier) as? WeatherViewHeaderCell ?? WeatherViewHeaderCell()
            DispatchQueue.main.async { [self] in
                let largeImg = UIImage.SymbolConfiguration(scale: .large)
                headerView.conditionImage.image = UIImage(systemName: weatherImageName ?? "", withConfiguration: largeImg)
                let measurementFormatter = MeasurementFormatter()
                measurementFormatter.locale = Locale(identifier: "ki_ke")
                let measurement = Measurement(value: temperature ?? 0.0, unit: UnitTemperature.celsius)
                headerView.temperatureLabel.text = measurementFormatter.string(from: measurement)
                headerView.citylabel.text = cityText ?? ""
            }
            return headerView
        } else {
            let _date = Date.stringToDate(dateString: sortedGroupedWeather?[section].key ?? "")
            let reformatedDate = Date.formatDate(from: _date)
            let date = Date.stringToDate(dateString: reformatedDate)
            let day = Date.getDayofTheWeek(from: date)

            let title = UILabel()
            title.font = UIFont.boldSystemFont(ofSize: 16)
            title.textColor = .label
            title.text = day
            return title
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == .zero ? view.frame.height / 3.5 : 18
    }
}

// MARK: - Delegate methods for location services

extension WeatherViewController: WeatherManagerDelegate, CLLocationManagerDelegate {
    func didFailWithError(error: Error) {
        debugPrint(error)
    }

    /// This is triggered when the weather data is fetched
    func didUpdateCurrentWeather(_ weathermanager: WeatherManager, weather: (WeatherModel, [ForecastWeatherModel])) {
        DispatchQueue.main.async { [self] in
            cityText = weather.0.cityName
            weatherImageName = weather.0.conditionName
            if weatherImageName!.contains("sun") {
                backgroundImage = UIImage(named: "sea_sunnypng")
                backgroundViewColor = .sunnyColor
            } else if weatherImageName!.contains("cloud.rain") {
                backgroundImage = UIImage(named: "sea_rainy")
                backgroundViewColor = .rainyColor
            } else {
                backgroundImage = UIImage(named: "sea_cloudy")
                backgroundViewColor = .cloudyColor
            }
            temperature = weather.0.temp!
            self.forecastWeather = weather.1
            self.groupByDay(weather.1)
            tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchWeatherLatLon(lat: lat, lon: lon)
            tableView.reloadData()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error)
    }
}

// MARK: - Delegate methods for UISearchController and UISearchBar

extension WeatherViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let city = searchController.searchBar.text {
            weathermanager.fetchWeather(cityName: city)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchController.searchBar.text {
            weathermanager.fetchWeather(cityName: city)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == .zero {
            locationManager.requestLocation()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        locationManager.requestLocation()
    }
}
