//
//  PodiumView.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/21/22.
//

import UIKit

class PodiumVStackView: UIStackView {

    let medalImage = UIImageView()
    let valueLabel = DPTitleLabel(textAlignment: .center, fontSize: 24)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        axis = .vertical
        distribution = .fillProportionally
        alignment = .center
        spacing = UIStackView.spacingUseSystem
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 3, leading: 5, bottom: 3, trailing: 5)
        medalImage.translatesAutoresizingMaskIntoConstraints = false
        medalImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            valueLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        addArrangedSubview(medalImage)
        addArrangedSubview(valueLabel)
    }
    
    func set(medal: UIImage, value: String) {
        medalImage.image = medal
        valueLabel.text = value
    }
}
