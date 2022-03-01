//
//  ResultData.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import Foundation

struct ResultData: Codable{
    let MRData: MRDataResults
}

struct MRDataResults: Codable {
    let RaceTable: RaceTable
}

struct RaceTable: Codable{
    let Races: [Races]
}

struct Races: Codable{
    let season: String
    let url: String
    let date: String
    let Results: [Results]
}

struct Results: Codable{
    let grid: String
    let position: String
    let positionText: String
    let points: String
    let status: String
    let Time: Time?
    let FastestLap: FastestLap?
    let Constructor: Constructor
}

struct Constructor: Codable {
    let name: String
}

struct Time: Codable{
    let time: String?
}

struct FastestLap: Codable{
    let rank: String?
    let lap: String?
    let Time: Time?
}
