//
//  WeatherForeCastCell.swift
//  Clima
//
//  Created by Nicholas Wakaba on 07/09/2022.
//

import Foundation
import UIKit
class WeatherForeCastCell: UITableViewCell {
    /// Initalize the views with values from the weather model
    /// 
    var dataSourceItem: WeatherModel? {
        didSet {
            guard let source = self.dataSourceItem  else { return }
            let largeImg = UIImage.SymbolConfiguration(scale: .large)
            conditionImage.image = UIImage(systemName: source.conditionName, withConfiguration: largeImg)
            let measurementFormatter = MeasurementFormatter()
            measurementFormatter.locale = Locale(identifier: "ki_ke")
            let measurement = Measurement(value: source.temp ?? 0.0, unit: UnitTemperature.celsius)
            temperatureLabel.text = measurementFormatter.string(from: measurement)
            dayLabel.text = source.cityName ?? ""
        }
    }
    
    lazy var conditionImage: UIImageView = {
        let h = UIImageView()
        h.tintColor = .label
        h.contentMode = .scaleAspectFit
        h.backgroundColor = .clear
        h.image = UIImage(systemName: "plus")
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var temperatureLabel: UILabel = {
        let h = UILabel()
        h.text = "32C"
        h.font = UIFont.boldSystemFont(ofSize: Constants.default_extra_large_font_size)
        h.numberOfLines = .zero
        h.textColor = .label
        h.contentMode = .scaleAspectFit
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var dayLabel: UILabel = {
        let h = UILabel()
        h.contentMode = .scaleAspectFit
        h.font = UIFont.boldSystemFont(ofSize: Constants.default_extra_large_font_size)
        h.numberOfLines = .zero
        h.textColor = .label
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    /// Setup the content views
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
        contentView.addSubview(dayLabel)
        contentView.addSubview(conditionImage)
        contentView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.default_padding),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.default_padding),
            dayLabel.trailingAnchor.constraint(equalTo: conditionImage.leadingAnchor, constant: -Constants.default_padding),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.default_padding),
            
            conditionImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            conditionImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            conditionImage.heightAnchor.constraint(equalToConstant: 50),
            
            temperatureLabel.topAnchor.constraint(equalTo: dayLabel.topAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.default_padding),
            temperatureLabel.bottomAnchor.constraint(equalTo: dayLabel.bottomAnchor),

        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
