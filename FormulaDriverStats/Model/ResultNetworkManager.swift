//
//  ResultNetworkManager.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import Foundation
protocol ResultNetworkManagerDelegate{
    func didUpdateResults(results: [Result])
    func didFailWithError(error: DPError)
}

struct ResultNetworkManager {
    let dataURL = "https://ergast.com/api/f1/"
    var delegate: ResultNetworkManagerDelegate?
    func getResults(driverId: String, circuitId: String, offset: Int){
        let endpoint = "\(dataURL)drivers/\(driverId)/circuits/\(circuitId)/results.json"
        guard let url = URL(string: endpoint) else {
            delegate?.didFailWithError(error: .invalidCircuit)
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
                    let decodedData = try decoder.decode(ResultData.self, from: data)
                    var results = [Result]()
                    for race in decodedData.MRData.RaceTable.Races {
                        let season = race.season
                        let url = race.url
                        let date = race.date
                        for resultData in race.Results {
                            let startPlace = resultData.grid
                            let endPlaceNumber = resultData.position
                            let endPlaceText = resultData.positionText.lowercased()
                            let points = resultData.points
                            let raceResultSummary = resultData.status.capitalized
                            let constructorName = resultData.Constructor.name
                            let timeOffFirst = resultData.Time?.time
                            let fastestLapLap = resultData.FastestLap?.lap
                            let fastestLapTime = resultData.FastestLap?.Time?.time
                            let fastestLapRank = resultData.FastestLap?.rank
                            let result = Result(season: season, url: url, date: date, constructorName: constructorName, startPlace: startPlace, endPlaceNumber: endPlaceNumber, endPlaceText: endPlaceText, points: points, raceResultSummary: raceResultSummary, timeOffFirst: timeOffFirst, fastestLapLap: fastestLapLap, fastestLapTime: fastestLapTime, fastestLapRank: fastestLapRank)
                            results.append(result)
                        }
                    }
                    //display most recent race result first
                    results.reverse()
                    delegate?.didUpdateResults(results: results)
                } catch {
                    delegate?.didFailWithError(error: .invalidData)
                }
            }
            task.resume()
    }
    
    func calculatePlaces(with results: [Result]) -> (String, String, String, String, String) {
        var first = 0
        var second = 0
        var third = 0
        var endPlaceSum = 0.0
        var startPlaceSum = 0.0
        
        for result in results {
            if result.endPlaceNumber == "1" {
                first += 1
            }
            if result.endPlaceNumber == "2" {
                second += 1
            }
            if result.endPlaceNumber == "3" {
                third += 1
            }
            startPlaceSum += Double(result.startPlace) ?? 0
            endPlaceSum += Double(result.endPlaceNumber) ?? 0
        }
        
        let firstString = String(first)
        let secondString = String(second)
        let thirdString = String(third)
        
        let avgQualDouble = startPlaceSum / Double(results.count)
        let avgFinDouble = endPlaceSum / Double(results.count)
        let roundAvgQualDouble = round(avgQualDouble * 10) / 10.0
        let roundAvgFinDouble = round(avgFinDouble * 10) / 10.0
        let averageQualString = String(roundAvgQualDouble )
        let averageFinString = String(roundAvgFinDouble)
        
        return(firstString, secondString, thirdString, averageQualString, averageFinString)
    }
}
