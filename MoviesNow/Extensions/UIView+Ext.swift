//
//  UIView+Ext.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/2/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
