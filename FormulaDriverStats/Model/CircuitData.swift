//
//  CircuitData.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import Foundation

struct CircuitData: Codable{
    let MRData: MRData
}

struct MRData: Codable {
    let CircuitTable: CircuitTable
}

struct CircuitTable: Codable{
    let Circuits: [Circuits]
}

struct Circuits: Codable{
    let circuitName: String
    let circuitId: String
    let url: String
    let Location: Location
}

struct Location: Codable{
    let locality: String
    let country: String
}

