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
        let gradientColors: [AnyObject] = [startColor, finalColor]
        backgroundLayer.colors = gradientColors
        backgroundLayer.locations = [0.0 ,1.0]
        self.backgroundColor = UIColor.clear
        self.layer.addSublayer(backgroundLayer)
    }
}
