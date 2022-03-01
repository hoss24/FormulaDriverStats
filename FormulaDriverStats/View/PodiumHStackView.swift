//
//  PodiumStackView.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/21/22.
//

import UIKit

class PodiumHStackView: UIStackView {

    let podiumViewOne = PodiumVStackView()
    let podiumViewTwo = PodiumVStackView()
    let podiumViewThree = PodiumVStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = 15
        addArrangedSubview(podiumViewOne)
        addArrangedSubview(podiumViewTwo)
        addArrangedSubview(podiumViewThree)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(first: String, second: String, third: String) {
        if let medal1 = UIImage(named: "medal1") {
            podiumViewOne.set(medal: medal1, value: first)
        }
        if let medal2 = UIImage(named: "medal2") {
            podiumViewTwo.set(medal: medal2, value: second)
        }
        if let medal3 = UIImage(named: "medal3") {
            podiumViewThree.set(medal: medal3, value: third)
        }
    }

}


