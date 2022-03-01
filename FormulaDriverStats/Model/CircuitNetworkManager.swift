//
//  CircuitNetworkManager.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import Foundation

protocol CircuitNetworkManagerDelegate{
    func didUpdateCircuits(circuits: [Circuit])
    func didFailWithError(error: DPError)
}

struct CircuitNetworkManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: CircuitNetworkManagerDelegate?
    func getCircuits(for driverId: String, offset: Int){
        let endpoint = "\(dataURL)drivers/\(driverId)/circuits.json?limit=50&offset=\(offset)"
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
                //decode json data
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(CircuitData.self, from: data)
                    var circuits = [Circuit]()
                    for circuit in decodedData.MRData.CircuitTable.Circuits {
                        let name = circuit.circuitName
                        let circuitId = circuit.circuitId
                        let url = circuit.url
                        let locality = circuit.Location.locality
                        let country = circuit.Location.country
                        let circuit = Circuit(circuitName: name, circuitId: circuitId, url: url, locality: locality, country: country)
                        circuits.append(circuit)
                    }
                    //order alphabettically
                    circuits = circuits.sorted(by: { circuit1, circuit2 in
                        let circuitName1 = circuit1.circuitName
                        let circuitName2 = circuit2.circuitName
                        return (circuitName1.localizedCaseInsensitiveCompare(circuitName2) == .orderedAscending)
                    })
                    delegate?.didUpdateCircuits(circuits: circuits)
                } catch {
                    delegate?.didFailWithError(error: .invalidData)
                }
            }
            task.resume()
    }
}
