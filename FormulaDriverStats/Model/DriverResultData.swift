//
//  DriverPodiumData.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/21/22.
//

import Foundation

struct DriverResultData: Codable{
    let MRData: MRDataDriversPodium
}

struct MRDataDriversPodium: Codable {
    let total: String
}
