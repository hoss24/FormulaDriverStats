//
//  DriverTableViewCell.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 1/28/22.
//

import UIKit

class DriverTableViewCell: UITableViewCell {
    
    static let reuseID = "DriverTableViewCell"
    let driverNameLabel = DPTitleLabel(textAlignment: .left, fontSize: 22)
    let driverNumberLabel = DPNumberLabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSubview(driverNameLabel)
        addSubview(driverNumberLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            driverNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            driverNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            driverNumberLabel.heightAnchor.constraint(equalToConstant: 50),
            driverNumberLabel.widthAnchor.constraint(equalToConstant: 50),
            
            driverNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            driverNameLabel.leadingAnchor.constraint(equalTo: driverNumberLabel.trailingAnchor, constant: padding),
            driverNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            driverNameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
