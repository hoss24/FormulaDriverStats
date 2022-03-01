//
//  ResultAverageView.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/21/22.
//

import UIKit

class ResultAverageStackView: UIStackView {
    
    let resultInfoViewOne = ResultInfoView()
    let resultInfoViewTwo = ResultInfoView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        backgroundColor = .systemBackground
        axis = .vertical
        distribution = .fillEqually
        alignment = .fill
        spacing = UIStackView.spacingUseSystem
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 3, leading: 10, bottom: 3, trailing: 5)
        addArrangedSubview(resultInfoViewOne)
        addArrangedSubview(resultInfoViewTwo)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(averageQualifying: String, averageFinish: String) {
        resultInfoViewOne.set(header: "Avg. Qual.", value: averageQualifying)
        resultInfoViewTwo.set(header: "Avg. Finish", value: averageFinish)
    }
    
    
}
