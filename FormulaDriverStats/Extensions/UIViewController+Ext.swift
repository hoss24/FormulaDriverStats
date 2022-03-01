//
//  UIViewController+Ext.swift
//  DriverPerformance
//
//  Created by Grant Matthias Hosticka on 2/6/22.
//

import UIKit
import SafariServices

//"fileprivate" anything in file can use variable
//unable to create variable in extension
fileprivate var containerView: UIView!

extension UIViewController {
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        
        //fade in
        containerView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    func hideLoadingView() {
        DispatchQueue.main.async {
            if  containerView != nil {
                containerView.removeFromSuperview()
                containerView = nil
            }
        }
    }
    func didFailWithError(error: DPError) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        hideLoadingView()
    }
}

