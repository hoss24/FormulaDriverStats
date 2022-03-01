//
//  DPError.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/5/22.
//

import Foundation

enum DPError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "Data recieved from server was invalid. Please try again."
    case invalidYear = "There was an issue with the year provided. Please try again."
    case noDrivers = "No drivers available for year input."
    case invalidDriver = "There was an issue finding circuit history for the driver provided. Please try again or select another driver."
    case invalidCircuit = "Issue find results for circuit. Please try again or select another option."
    case noLink = "No link available for this race"
}
