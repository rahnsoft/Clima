//
//  ViewController.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 01/12/2020.
//

import UIKit

class WeatherViewHeaderCell: UITableViewHeaderFooterView {
    lazy var conditionImage: UIImageView = {
        let h = UIImageView()
        h.tintColor = .label
        h.contentMode = .scaleAspectFill
        h.backgroundColor = .clear
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var temperatureLabel: UILabel = {
        let h = UILabel()
        h.font = UIFont.boldSystemFont(ofSize: Constants.default_extra_large_font_size * 2)
        h.numberOfLines = .zero
        h.textColor = .label
        h.contentMode = .scaleAspectFit
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var citylabel: UILabel = {
        let h = UILabel()
        h.contentMode = .scaleAspectFit
        h.font = UIFont.boldSystemFont(ofSize: Constants.default_extra_large_font_size)
        h.numberOfLines = .zero
        h.textColor = .label
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    /// Setup the content views
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(conditionImage)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(citylabel)
        
        NSLayoutConstraint.activate([
            conditionImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.default_padding),
            conditionImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            conditionImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4),
            conditionImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 5),
            conditionImage.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -Constants.default_padding),
            
            temperatureLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor, constant:  Constants.default_padding),
            temperatureLabel.centerXAnchor.constraint(equalTo: conditionImage.centerXAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: citylabel.topAnchor, constant: -Constants.default_padding),
            
            citylabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Constants.default_padding),
            citylabel.centerXAnchor.constraint(equalTo: conditionImage.centerXAnchor),
            citylabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.default_padding * 3)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
