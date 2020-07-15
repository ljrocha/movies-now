//
//  MNUserScoreLabel.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/2/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNUserScoreLabel: UILabel {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func set(rating: Int) {
        text = " \(rating)%"
        
        let center = CGPoint(x: 25, y: 25)
        let circularPath = UIBezierPath(arcCenter: center, radius: 25, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        
        // Track layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 5
        trackLayer.lineCap = .round
        layer.addSublayer(trackLayer)
        
        // Shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor(forRating: rating)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = CGFloat(rating) / 100
        basicAnimation.duration = 1
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basic")
    }
    
    // MARK: - Private methods
    
    private func configure() {
        font = UIFont.systemFont(ofSize: 12, weight: .medium)
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func strokeColor(forRating rating: Int) -> CGColor {
        switch rating {
        case ..<40:
            return UIColor.red.cgColor
        case ..<70:
            return UIColor.yellow.cgColor
        default:
            return UIColor.green.cgColor
        }
    }

}
