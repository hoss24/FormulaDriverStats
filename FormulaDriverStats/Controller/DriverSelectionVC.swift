//
//  YearSelectionVC.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 1/25/22.
//

import UIKit

class DriverSelectionVC: UIViewController {
    let driverTableView = UITableView()
    var driverNetworkManager = DriverNetworkManager()
    var drivers: [Driver] = []
    var year = "current" {
        didSet {
            DispatchQueue.main.async {
                if self.year != "current" { self.title = "\(self.year) Drivers" }
            }
        }
    }
    var offset = 0
    var hasMoreDrivers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        driverNetworkManager.delegate = self
        configureViewController()
        configureTableView()
        dateUpdated(to: year)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let editDateButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(openDateSelectionVC))
        navigationItem.rightBarButtonItem = editDateButton
    }
    
    @objc func openDateSelectionVC() {
        let destVC = YearSelectionVC()
        destVC.delegate = self
        destVC.year = year
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func configureTableView() {
        view.addSubview(driverTableView)
        driverTableView.delegate = self
        driverTableView.dataSource = self
        driverTableView.backgroundColor = .systemBackground
        driverTableView.frame = view.bounds
        driverTableView.rowHeight = 80
        driverTableView.register(DriverTableViewCell.self, forCellReuseIdentifier: DriverTableViewCell.reuseID)
    }
}

extension DriverSelectionVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverTableViewCell", for: indexPath) as! DriverTableViewCell
        cell.driverNameLabel.text = drivers[indexPath.row].name
        cell.driverNumberLabel.text = drivers[indexPath.row].number
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //check when bottom of current table view values has been reached
        if indexPath.row + 1 == drivers.count && hasMoreDrivers {
            DispatchQueue.global().async {
                self.driverNetworkManager.getDrivers(in: self.year, offset: self.offset)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CircuitSelectionVC()
        vc.driver = drivers[indexPath.row]
        driverTableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DriverSelectionVC: DriverNetworkManagerDelegate {
    func didUpdateDrivers(drivers: [Driver], season: String) {
        self.year = season
        hideLoadingView()
        self.drivers.append(contentsOf: drivers)
        if self.drivers.isEmpty {
            didFailWithError(error: .noDrivers)
            return
        }
        //check if there are additional drivers that can be loaded
        if drivers.count == 30{
            offset += 30
            hasMoreDrivers = true
        } else {
            hasMoreDrivers = false
        }
        DispatchQueue.main.async {
            self.driverTableView.reloadData()
        }
    }
}

extension DriverSelectionVC: YearSelectionVCDelegate {
    func dateUpdated(to year: String) {
        offset = 0
        hasMoreDrivers = true
        self.year = year
        if drivers.count > 0 {
            drivers.removeAll()
            driverTableView.reloadData()
        }
        showLoadingView()
        DispatchQueue.global().async {
            self.driverNetworkManager.getDrivers(in: year, offset: self.offset)
        }
    }
}
    
