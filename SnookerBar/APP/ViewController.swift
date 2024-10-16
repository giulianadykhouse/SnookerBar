//
//  ViewController.swift
//  SnookerBar
//
//  Created by D K on 02.10.2024.
//

import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImageView = UIImageView(image: UIImage(named: "bg1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0)
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont(name: "Times New Roman", size: 31)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
                
        view.addSubview(loadingLabel)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 20)
        ])
    }

    
    func openApp() {
        DispatchQueue.main.async {
            let view = InitialRootView()
            let hostingController = UIHostingController(rootView: view)
            self.setRootViewController(hostingController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            let webView = ADJWebHandler(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, advertiseID: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?sdjv=\(deviceID)&cxbr=\(advertiseID)"
        
        return url
    }
}

