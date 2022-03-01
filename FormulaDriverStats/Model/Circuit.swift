//
//  Circuit.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 1/28/22.
//

import UIKit

struct Circuit {
    let circuitName: String
    let circuitId: String
    let url: String
    let locality: String
    let country: String
    var countryFlag: UIImage{
        switch country {
        case "Argentina":
            return UIImage(named: "ar")!
        case "Australia":
            return UIImage(named: "au")!
        case "Austria":
            return UIImage(named: "at")!
        case "Azerbaijan":
            return UIImage(named: "az")!
        case "Bahrain":
            return UIImage(named: "bh")!
        case "Belgium":
            return UIImage(named: "be")!
        case "Brazil":
            return UIImage(named: "br")!
        case "Canada":
            return UIImage(named: "ca")!
        case "China":
            return UIImage(named: "cn")!
        case "France":
            return UIImage(named: "fr")!
        case "Germany":
            return UIImage(named: "de")!
        case "Hungary":
            return UIImage(named: "hu")!
        case "India":
            return UIImage(named: "in")!
        case "Italy":
            return UIImage(named: "it")!
        case "Japan":
            return UIImage(named: "jp")!
        case "Korea":
            return UIImage(named: "kr")!
        case "Malaysia":
            return UIImage(named: "my")!
        case "Mexico":
            return UIImage(named: "mx")!
        case "Monaco":
            return UIImage(named: "mc")!
        case "Morocco":
            return UIImage(named: "ma")!
        case "Netherlands":
            return UIImage(named: "nl")!
        case "Portugal":
            return UIImage(named: "pt")!
        case "Qatar":
            return UIImage(named: "qa")!
        case "Russia":
            return UIImage(named: "ru")!
        case "Saudi Arabia":
            return UIImage(named: "sa")!
        case "Singapore":
            return UIImage(named: "sg")!
        case "South Africa":
            return UIImage(named: "za")!
        case "Spain":
            return UIImage(named: "es")!
        case "Sweden":
            return UIImage(named: "se")!
        case "Switzerland":
            return UIImage(named: "ch")!
        case "Turkey":
            return UIImage(named: "tr")!
        case "UAE":
            return UIImage(named: "ae")!
        case "UK":
            return UIImage(named: "gb")!
        case "United States":
            return UIImage(named: "us")!
        case "USA":
            return UIImage(named: "us")!
        case "Vietnam":
            return UIImage(named: "vn")!
        default:
            return UIImage(named: "car")!
        }
    }
}
