//
//  YearSelectionVC.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/5/22.
//

import UIKit

protocol YearSelectionVCDelegate {
    func dateUpdated(to year: String)
}

class YearSelectionVC: UIViewController {
    var year = "2021"
    var years =  [String]()
    var delegate: YearSelectionVCDelegate?
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configurePickerView()
        layoutViews()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Edit Year"
        navigationController?.navigationBar.prefersLargeTitles = false
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateYearDismissVC))
        doneButton.tintColor = .systemRed
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configurePickerView() {
        //data starts in 1950, display current year first
        for i in (1950...Calendar.current.component(.year, from: Date())).reversed() {
                years.append("\(i)")
        }
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        //select year currently being displayed
        let yearDifference = Calendar.current.component(.year, from: Date()) - Int(year)!
        picker.selectRow(yearDifference, inComponent: 0, animated: true)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            picker.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func updateYearDismissVC() {
        delegate?.dateUpdated(to: year)
        dismiss(animated: true)
    }
}

extension  YearSelectionVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.years.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let year = self.years[row]
        return year
    }
    func view(forRow row: Int, forComponent component: Int) -> UIView? {
        let label =  UILabel()
        return label
    }
}

extension YearSelectionVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        year = self.years[row]
    }
}
