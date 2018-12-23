//
//  Constants.swift
//  ProiectBD
//
//  Created by Andrei Popa on 21/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    
    static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let red              = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let orange           = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    static let blue             = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static let green            = UIColor(red: 91.0/255.0, green: 197.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    static let darkGrey         = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
    static let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}



typealias GradientType = (x: CGPoint, y: CGPoint)

struct GradientDirection {
    static let leftRight =  (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
    static let rightLeft = (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
    static let topBottom = (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
    static let bottomTop = (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
    static let topLeftBottomRight = (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
    static let bottomRightTopLeft = (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
    static let topRightBottomLeft = (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
    static let bottomLeftTopRight = (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
}
