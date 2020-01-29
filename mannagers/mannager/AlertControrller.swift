//
//  AlertControrller.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 12.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation
import UIKit

var loadingAlertController: UIAlertController = {
    
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.medium
    loadingIndicator.startAnimating()
    
    alert.view.addSubview(loadingIndicator)
    
    return alert
}()


extension UIViewController {
    func showErrorAlert(message:String, title:String? = "Error") {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
