//
//  DPNumberLabel.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/3/22.
//

import UIKit

class DPNumberLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        backgroundColor = .red
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 28, weight: .bold)
        layer.cornerRadius = 6
        layer.masksToBounds = true
    }

}
