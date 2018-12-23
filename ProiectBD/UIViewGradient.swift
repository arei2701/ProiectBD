//
//  UIViewGradient.swift
//  ProiectBD
//
//  Created by Andrei Popa on 21/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import Foundation

import UIKit

extension UIView {
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, dir: GradientType) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = dir.x
        gradientLayer.endPoint = dir.y
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
