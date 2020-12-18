//
//  ViewController.swift
//  Clima
//
//  Created by IOS DEV PRO 1 on 01/12/2020.
//

import UIKit

class WeatherView: UIView {
    lazy var headerView: UIView = {
        let h = UIView()
        h.contentMode = .scaleAspectFit
        h.backgroundColor = .clear
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var locationBtn: UIButton = {
        let h = UIButton()
        h.titleLabel?.text = "location"
        h.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        h.imageView?.contentMode = .scaleAspectFit
        h.tintColor = UIColor(named: "TextColor")
        h.contentVerticalAlignment = .fill
        h.contentHorizontalAlignment = .fill
        h.backgroundColor  = .clear
        h.contentMode = .scaleAspectFit
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var locationText: UITextField = {
        let h = UITextField()
        h.borderStyle = .none
        let attr : [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Times New Roman", size: 25)!]
        h.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attr)
        h.textAlignment = .natural
        h.returnKeyType = .go
        h.contentMode = .scaleAspectFit
        h.layer.cornerRadius = 5
        h.layer.masksToBounds = true
        h.backgroundColor = UIColor(named: "backgroundColor-location")
        h.textColor = UIColor(named: "TextColor")
        h.isUserInteractionEnabled = true
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var searchBtn: UIButton = {
        let h = UIButton()
        h.titleLabel?.text = "search"
        h.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        h.imageView?.contentMode = .scaleAspectFit
        h.tintColor = UIColor(named: "TextColor")
        h.contentVerticalAlignment = .fill
        h.contentHorizontalAlignment = .fill
        h.clipsToBounds = true
        h.contentMode = .scaleAspectFit
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var conditionImage: UIImageView = {
        let h = UIImageView()
        h.tintColor = UIColor(named: "TextColor")
        h.contentMode = .scaleAspectFill
        h.backgroundColor = .clear
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var temperatureLabel: UILabel = {
        let h = UILabel()
        h.font = UIFont.boldSystemFont(ofSize: 60)
        h.numberOfLines = .zero
        h.textColor = UIColor(named: "TextColor")
        h.contentMode = .scaleAspectFit
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var citylabel: UILabel = {
        let h = UILabel()
        h.contentMode = .scaleAspectFit
        h.font = UIFont.boldSystemFont(ofSize: 30)
        h.numberOfLines = .zero
        h.textColor = UIColor(named: "TextColor")
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraintsAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraintsAll(){
        addSubview(headerView)
        headerView.addSubview(locationBtn)
        headerView.addSubview(locationText)
        headerView.addSubview(searchBtn)
        addSubview(conditionImage)
        addSubview(temperatureLabel)
        addSubview(citylabel)
        NSLayoutConstraint.activate([

            locationBtn.topAnchor.constraint(equalTo: headerView.topAnchor),
            locationBtn.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            locationBtn.trailingAnchor.constraint(equalTo: locationText.leadingAnchor, constant: -10),
            locationBtn.heightAnchor.constraint(equalToConstant: 50),
            locationBtn.widthAnchor.constraint(equalToConstant: 50),
            locationBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            locationText.topAnchor.constraint(equalTo: headerView.topAnchor),
            locationText.leadingAnchor.constraint(equalTo: locationBtn.trailingAnchor, constant: 10),
            locationText.trailingAnchor.constraint(equalTo: searchBtn.leadingAnchor, constant: -10),
            locationText.heightAnchor.constraint(equalToConstant: 50),
            locationText.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBtn.topAnchor.constraint(equalTo: headerView.topAnchor),
            searchBtn.leadingAnchor.constraint(equalTo: locationText.trailingAnchor, constant: 10),
            searchBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant:  -10),
            searchBtn.heightAnchor.constraint(equalToConstant: 50),
            searchBtn.widthAnchor.constraint(equalToConstant: 50),
            searchBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.bottomAnchor.constraint(equalTo: conditionImage.topAnchor, constant: -60),
            
            conditionImage.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 60),
            conditionImage.leadingAnchor.constraint(equalTo: conditionImage.leadingAnchor),
            conditionImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            conditionImage.widthAnchor.constraint(equalToConstant: 100),
            conditionImage.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor,constant: -40),
            
            temperatureLabel.topAnchor.constraint(equalTo: conditionImage.bottomAnchor,constant: 40),
            temperatureLabel.trailingAnchor.constraint(equalTo: conditionImage.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: citylabel.topAnchor, constant: -10),
            
            citylabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            citylabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor),
            citylabel.bottomAnchor.constraint(equalTo: citylabel.bottomAnchor)
            
        ])
    }
}

