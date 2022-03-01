//
//  CircuitTableViewCell.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import UIKit

class CircuitTableViewCell: UITableViewCell {
    
    static let reuseID = "CircuitTableViewCell"
    
    let circuitNameLabel = DPTitleLabel(textAlignment: .left, fontSize: 22)
    let circuitCountryFlag = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubview(circuitNameLabel)
        addSubview(circuitCountryFlag)
        circuitNameLabel.numberOfLines = 2
        circuitCountryFlag.translatesAutoresizingMaskIntoConstraints = false
        circuitCountryFlag.clipsToBounds = true
        circuitCountryFlag.image = UIImage(named: "car")
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            circuitCountryFlag.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circuitCountryFlag.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            circuitCountryFlag.heightAnchor.constraint(equalToConstant: 36),
            circuitCountryFlag.widthAnchor.constraint(equalToConstant: 48),
            
            circuitNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circuitNameLabel.leadingAnchor.constraint(equalTo: circuitCountryFlag.trailingAnchor, constant: padding),
            circuitNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            circuitNameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
