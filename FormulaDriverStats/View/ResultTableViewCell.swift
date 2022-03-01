//
//  ResultTableViewCell.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/18/22.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    static let reuseID = "ResultTableViewCell"
    let roundedView = UIView()
    let resultNameLabel = DPTitleLabel(textAlignment: .left, fontSize: 24)
    let resultEndPlaceImage = UIImageView()
    let dateImage = UIImageView()
    let dateLabel = DPSubTitleLabel(textAlignment: .left, fontSize: 18)
    let constructorImage = UIImageView()
    let constructorLabel = DPSubTitleLabel(textAlignment: .left, fontSize: 18)
    let stackView = UIStackView()
    let resultInfoViewOne = ResultInfoView()
    let resultInfoViewTwo = ResultInfoView()
    let resultInfoViewThree = ResultInfoView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(result: Result) {
        resultNameLabel.text = result.raceResultSummary + " " + (result.timeOffFirst ?? "")
        resultEndPlaceImage.image = UIImage(systemName: "\(result.endPlaceText).circle.fill")
        switch result.endPlaceText {
        case "r":
            resultEndPlaceImage.tintColor = .systemRed
        case "1":
            resultEndPlaceImage.tintColor = .systemYellow
        case "2":
            resultEndPlaceImage.tintColor = .systemGray
        case "3":
            resultEndPlaceImage.tintColor = .systemBrown
        default:
            resultEndPlaceImage.tintColor = .label
        }
        dateImage.image = UIImage(systemName: "calendar")
        dateImage.tintColor = .secondaryLabel
        dateLabel.text = result.date
        constructorImage.image = UIImage(systemName: "person.2")
        constructorImage.tintColor = .secondaryLabel
        constructorLabel.text = result.constructorName
        resultInfoViewOne.set(header: "Qualified", value: result.startPlace)
        if let fastestLapTime = result.fastestLapTime{
            resultInfoViewTwo.set(header: "Fast Lap", value: fastestLapTime)
        }
        if let fastestLapRank = result.fastestLapRank{
            resultInfoViewThree.set(header: "FL Rank", value: fastestLapRank)
        }
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
    
        stackView.addArrangedSubview(resultInfoViewOne)
        stackView.addArrangedSubview(resultInfoViewTwo)
        stackView.addArrangedSubview(resultInfoViewThree)
    }

    func configure() {
        addSubview(roundedView)
        addSubview(resultEndPlaceImage)
        addSubview(resultNameLabel)
        addSubview(dateImage)
        addSubview(dateLabel)
        addSubview(constructorImage)
        addSubview(constructorLabel)
        addSubview(stackView)
        
        //round corners of cells and add a shadow
        applyShadow(cornerRadius: 8)
        backgroundColor = .clear
        roundedView.backgroundColor = .systemBackground
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.layer.cornerRadius = 8
        roundedView.layer.masksToBounds = true
        
        resultNameLabel.numberOfLines = 2
        dateLabel.numberOfLines = 1
        constructorLabel.numberOfLines = 1
        resultEndPlaceImage.translatesAutoresizingMaskIntoConstraints = false
        resultEndPlaceImage.contentMode = .scaleAspectFill
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        dateImage.contentMode = .scaleAspectFill
        constructorImage.translatesAutoresizingMaskIntoConstraints = false
        constructorImage.contentMode = .scaleAspectFill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            roundedView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            roundedView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            roundedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            roundedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),

            resultEndPlaceImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            resultEndPlaceImage.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            resultEndPlaceImage.heightAnchor.constraint(equalToConstant: 36),
            resultEndPlaceImage.widthAnchor.constraint(equalToConstant: 36),
            
            resultNameLabel.leadingAnchor.constraint(equalTo: resultEndPlaceImage.trailingAnchor, constant: padding),
            resultNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            resultNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            resultNameLabel.heightAnchor.constraint(equalToConstant: 36),
            
            constructorImage.leadingAnchor.constraint(equalTo: resultNameLabel.leadingAnchor),
            constructorImage.topAnchor.constraint(equalTo: resultNameLabel.bottomAnchor),
            constructorImage.heightAnchor.constraint(equalToConstant: 24),
            constructorImage.widthAnchor.constraint(equalToConstant: 24),
            
            constructorLabel.leadingAnchor.constraint(equalTo: constructorImage.trailingAnchor, constant: 8),
            constructorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            constructorLabel.heightAnchor.constraint(equalToConstant: 24),
            constructorLabel.topAnchor.constraint(equalTo: resultNameLabel.bottomAnchor),
            
            dateImage.leadingAnchor.constraint(equalTo: resultNameLabel.leadingAnchor),
            dateImage.topAnchor.constraint(equalTo: constructorImage.bottomAnchor, constant: 4),
            dateImage.heightAnchor.constraint(equalToConstant: 24),
            dateImage.widthAnchor.constraint(equalToConstant: 24),
            
            dateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            dateLabel.topAnchor.constraint(equalTo: constructorLabel.bottomAnchor, constant: 4),
            
            stackView.leadingAnchor.constraint(equalTo: resultNameLabel.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: dateImage.bottomAnchor, constant: padding)
        ])
    }
}
