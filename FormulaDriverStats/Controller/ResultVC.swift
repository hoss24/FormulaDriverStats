//
//  ResultVC.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import UIKit

import UIKit

class ResultVC: UIViewController {

    let resultAverageStackView = ResultAverageStackView()
    let podiumStackView = PodiumHStackView()
    let resultTableView = UITableView()
    var resultNetworkManager = ResultNetworkManager()
    var results: [Result] = []
    var driver: Driver!
    var circuit: Circuit! {
        didSet {
            DispatchQueue.main.async {
                self.title = "\(self.circuit.circuitName)"
            }
        }
    }
    var offset = 0
    var hasMoreResults = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultNetworkManager.delegate = self
        configureViewController()
        configureViews()
        updateResults(driver: driver.driverId, circuit: circuit.circuitId)
    }
    
    func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        let infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(openURL))
        navigationItem.rightBarButtonItem = infoButton
    }
    
    @objc func openURL() {
        guard let link = URL(string: circuit.url) else {
            didFailWithError(error: .noLink)
            return
        }
        presentSafariVC(with: link)
    }
    
    func configureViews() {
        view.addSubview(resultAverageStackView)
        view.addSubview(podiumStackView)
        view.addSubview(resultTableView)
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.backgroundColor = .secondarySystemBackground
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            resultAverageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            resultAverageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            resultAverageStackView.heightAnchor.constraint(equalToConstant: 105),
            resultAverageStackView.widthAnchor.constraint(equalToConstant: 105),
            
            podiumStackView.leadingAnchor.constraint(equalTo: resultAverageStackView.trailingAnchor, constant: padding),
            podiumStackView.centerYAnchor.constraint(equalTo: resultAverageStackView.centerYAnchor),
            podiumStackView.heightAnchor.constraint(equalToConstant: 105),
            podiumStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            resultTableView.topAnchor.constraint(equalTo: podiumStackView.bottomAnchor, constant: 10),
            resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        resultTableView.rowHeight = 174
        resultTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.reuseID)
    }
    
    func updateResults(driver: String, circuit: String) {
        offset = 0
        hasMoreResults = true
        if results.count > 0 {
            results.removeAll()
            resultTableView.reloadData()
        }
        showLoadingView()
        DispatchQueue.global().async {
            self.resultNetworkManager.getResults(driverId: driver, circuitId: circuit, offset: self.offset)
        }
    }
    
    func updateDriverResultViews() {
        showLoadingView()
        let places = resultNetworkManager.calculatePlaces(with: results)
        podiumStackView.set(first: places.0, second: places.1, third: places.2)
        resultAverageStackView.set(averageQualifying: places.3, averageFinish: places.4)
        hideLoadingView()
    }
}

extension ResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        let result = results[indexPath.row]
        cell.set(result: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //detectBottom
        if indexPath.row + 1 == results.count && hasMoreResults {
            DispatchQueue.global().async {
                self.resultNetworkManager.getResults(driverId: self.driver.driverId, circuitId: self.circuit.circuitId, offset: self.offset)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = URL(string: results[indexPath.row].url) else {
            didFailWithError(error: .noLink)
            return
        }
        presentSafariVC(with: link)
        resultTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ResultVC: ResultNetworkManagerDelegate {
    func didUpdateResults(results: [Result]) {
        hideLoadingView()
        self.results.append(contentsOf: results)
        if self.results.isEmpty {
            didFailWithError(error: .noDrivers)
            return
        }
        if results.count == 30{
            offset += 30
            hasMoreResults = true
        } else {
            hasMoreResults = false
        }
        DispatchQueue.main.async {
            self.resultTableView.reloadData()
            self.updateDriverResultViews()
        }
    }
}
