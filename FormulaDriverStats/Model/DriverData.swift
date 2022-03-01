//
//  DriverData.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/4/22.
//

import Foundation

struct DriverData: Codable{
    let MRData: MRDataDrivers
}

struct MRDataDrivers: Codable {
    let DriverTable: DriverTable
}

struct DriverTable: Codable{
    let season: String
    let Drivers: [Drivers]
}

struct Drivers: Codable{
    let driverId: String
    let permanentNumber: String?
    let givenName: String
    let familyName: String
}


