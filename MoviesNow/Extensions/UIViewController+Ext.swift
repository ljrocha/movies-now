//
//  UIViewController+Ext.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/9/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: buttonTitle, style: .default))
            self.present(ac, animated: true)
        }
    }
}
