//
//  UIView+Extensions.swift
//  Transactions
//
//  Created by Thiago Santiago on 1/18/19.
//  Copyright © 2019 Thiago Santiago. All rights reserved.
//

import UIKit

extension UIView {
    
    func setShadow(color: CGColor, opacity: Float, shadowRadius: CGFloat){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowRadius = shadowRadius
    }
    
    func setImageBorder(color: CGColor, width: CGFloat, radius: CGFloat) {
        self.layer.borderColor = color
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    func setGradient(startColor: CGColor, finalColor: CGColor) {
        let backgroundLayer = CAGradientLayer()
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bounds.height)
        let gradientColors: [AnyObject] = [startColor, finalColor]
        backgroundLayer.colors = gradientColors
        backgroundLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.backgroundColor = UIColor.clear
        self.layer.insertSublayer(backgroundLayer, below: self.subviews.first?.layer)
    }
}

