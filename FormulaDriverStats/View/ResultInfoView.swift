//
//  ResultInfoView.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/20/22.
//

import UIKit

class ResultInfoView: UIView {
    
    let headerLabel = DPSubTitleLabel(textAlignment: .left, fontSize: 18)
    let valueLabel = DPTitleLabel(textAlignment: .left, fontSize: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(headerLabel)
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 22),
            
            valueLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func set(header: String, value: String) {
        headerLabel.text = header
        valueLabel.text = value
    }
}
