//
//  MNUserScoreView.swift
//  MoviesNow
//
//  Created by Leandro Rocha on 7/2/20.
//  Copyright © 2020 Leandro Rocha. All rights reserved.
//

import UIKit

class MNUserScoreView: UIView {
    
    let userScoreLabel = MNLabel(fontSize: 12, weight: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(userScoreLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            userScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            userScoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            userScoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            userScoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
    
    func set(rating: Int) {
        userScoreLabel.text = " \(rating)%"
        
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
        shapeLayer.strokeColor = UIColor.green.cgColor
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

}
