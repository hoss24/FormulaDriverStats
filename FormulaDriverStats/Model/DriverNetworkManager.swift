//
//  DriverNetworkManager.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/4/22.
//

import Foundation

protocol DriverNetworkManagerDelegate{
    func didUpdateDrivers(drivers: [Driver], season: String)
    func didFailWithError(error: DPError)
}

struct DriverNetworkManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: DriverNetworkManagerDelegate?
    func getDrivers(in year: String, offset: Int){
        let endpoint = "\(dataURL)\(year)/drivers.json?offset=\(offset)"
        guard let url = URL(string: endpoint) else {
            delegate?.didFailWithError(error: .invalidYear)
            return
        }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: .unableToComplete)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    delegate?.didFailWithError(error: .invalidResponse)
                    return
                }
                guard let data = data else {
                    delegate?.didFailWithError(error: .invalidData)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(DriverData.self, from: data)
                    var drivers = [Driver]()
                    let season = decodedData.MRData.DriverTable.season
                    for driver in decodedData.MRData.DriverTable.Drivers {
                        let name = driver.givenName + " " + driver.familyName
                        let number = driver.permanentNumber
                        let driverId = driver.driverId
                        let driver = Driver(name: name, number: number ?? "~", driverId: driverId)
                        drivers.append(driver)
                    }
                    delegate?.didUpdateDrivers(drivers: drivers, season: season)
                } catch {
                    delegate?.didFailWithError(error: .invalidData)
                }
            }
            task.resume()
    }
}
