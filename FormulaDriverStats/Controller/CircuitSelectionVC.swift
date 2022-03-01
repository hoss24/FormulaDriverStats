//
//  CircuitSelectionVC.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/11/22.
//

import UIKit

class CircuitSelectionVC: UIViewController {

    let circuitTableView = UITableView()
    var circuitNetworkManager = CircuitNetworkManager()
    var driverResultsNetworkManager = DriverResultNetworkManager()
    let podiumStackView = PodiumHStackView()
    var circuits: [Circuit] = []
    var driver: Driver! {
        didSet {
            DispatchQueue.main.async {
                self.title = "\(self.driver.name)"
            }
        }
    }
    var offset = 0
    var hasMoreCircuits = true
    
    var driverResultsFirst = "0"
    var driverResultsSecond = "0"
    var driverResultsThird = "0"
    var driverResultsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circuitNetworkManager.delegate = self
        driverResultsNetworkManager.delegate = self
        configureViewController()
        configureViews()
        updateDriverResults(with: driver.driverId)
        updateCircuits(with: driver.driverId)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    func configureViews() {
        view.addSubview(podiumStackView)
        view.addSubview(circuitTableView)
        circuitTableView.delegate = self
        circuitTableView.dataSource = self
        circuitTableView.backgroundColor = .systemBackground
        circuitTableView.translatesAutoresizingMaskIntoConstraints = false
        podiumStackView.isHidden = true
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            podiumStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            podiumStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            podiumStackView.heightAnchor.constraint(equalToConstant: 86),
            podiumStackView.widthAnchor.constraint(equalToConstant: 210),
            
            circuitTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            circuitTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            circuitTableView.topAnchor.constraint(equalTo: podiumStackView.bottomAnchor, constant: 10),
            circuitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        circuitTableView.rowHeight = 80
        circuitTableView.register(CircuitTableViewCell.self, forCellReuseIdentifier: CircuitTableViewCell.reuseID)
    }
    
    func updateCircuits(with driver: String) {
        offset = 0
        hasMoreCircuits = true
        if circuits.count > 0 {
            circuits.removeAll()
            circuitTableView.reloadData()
        }
        showLoadingView()
        DispatchQueue.global().async {
            self.circuitNetworkManager.getCircuits(for: driver, offset: self.offset)
        }
    }
    
    func updateDriverResults(with driver: String) {
        DispatchQueue.global().async {
            self.driverResultsNetworkManager.getDriverResults(for: driver, in: "1")
            self.driverResultsNetworkManager.getDriverResults(for: driver, in: "2")
            self.driverResultsNetworkManager.getDriverResults(for: driver, in: "3")
        }
    }
}

extension CircuitSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circuits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CircuitTableViewCell", for: indexPath) as! CircuitTableViewCell
        cell.circuitNameLabel.text = circuits[indexPath.row].circuitName
        cell.circuitCountryFlag.image = circuits[indexPath.row].countryFlag
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //detectBottom
        if indexPath.row + 1 == circuits.count && hasMoreCircuits {
            DispatchQueue.global().async {
                self.circuitNetworkManager.getCircuits(for: self.driver.driverId, offset: self.offset)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResultVC()
        vc.driver = driver
        vc.circuit = circuits[indexPath.row]
        circuitTableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CircuitSelectionVC: CircuitNetworkManagerDelegate {
    func didUpdateCircuits(circuits: [Circuit]) {
        hideLoadingView()
        self.circuits.append(contentsOf: circuits)
        if self.circuits.isEmpty {
            didFailWithError(error: .noDrivers)
            return
        }
        if circuits.count == 50{
            offset += 50
            hasMoreCircuits = true
        } else {
            hasMoreCircuits = false
        }
        
        DispatchQueue.main.async {
            self.circuitTableView.reloadData()
        }
    }
    
}

extension CircuitSelectionVC: DriverResultNetworkManagerDelegate {
    func didUpdateDriverResults(place: String, total: String) {
        driverResultsCount += 1
        if place == "1" {
            driverResultsFirst = total
        } else if place == "2" {
            driverResultsSecond = total
        } else if place == "3" {
            driverResultsThird = total
        }
        
        if driverResultsCount == 3 {
            DispatchQueue.main.async {
                self.podiumStackView.set(first: self.driverResultsFirst, second: self.driverResultsSecond, third: self.driverResultsThird)
                self.podiumStackView.isHidden = false
            }
        }
        
    }
}
    

