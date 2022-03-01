//
//  Result.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 1/28/22.
//

import Foundation
import UIKit

//drivers results at a specific race
struct Result {
    // season (year)
    let season: String
    // link to specific race
    let url: String
    // date of race
    let date: String
    // team name
    let constructorName: String
    let startPlace: String //grid
    //ending place numerical
    let endPlaceNumber: String //position
    //ending place which is a letter if driver did not finish
    let endPlaceText: String //positionText
    //total points from race
    let points: String
    //summary of race result
    let raceResultSummary: String //status
    //how close driver was to first or finishing time
    let timeOffFirst: String? //time
    //the lap when the drivers fastest lap occured
    let fastestLapLap: String?
    let fastestLapTime: String?
    let fastestLapRank: String?
}
