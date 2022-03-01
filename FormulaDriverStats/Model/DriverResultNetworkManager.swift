//
//  DriverPodiumNetworkManager.swift
//  FormulaDriverStats
//
//  Created by Grant Matthias Hosticka on 2/27/22.
//

import Foundation

protocol DriverResultNetworkManagerDelegate{
    func didUpdateDriverResults(place: String, total: String)
    func didFailWithError(error: DPError)
}

struct DriverResultNetworkManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: DriverResultNetworkManagerDelegate?
    func getDriverResults(for driverId: String, in place: String){
        let endpoint = "\(dataURL)drivers/\(driverId)/results/\(place).json?limit=0"
        guard let url = URL(string: endpoint) else {
            delegate?.didFailWithError(error: .invalidDriver)
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
                    let decodedData = try decoder.decode(DriverResultData.self, from: data)
                    let total = decodedData.MRData.total
                    delegate?.didUpdateDriverResults(place: place, total: total)
                } catch {
                    delegate?.didFailWithError(error: .invalidData)
                }
            }
            task.resume()
    }
}
