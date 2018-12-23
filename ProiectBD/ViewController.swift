//
//  ViewController.swift
//  ProiectBD
//
//  Created by Andrei Popa on 20/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBtn(button: registerBtn)
        configureBtn(button: loginBtn)
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        
    }
    func configureBtn(button: UIButton) {
        //let border = CALayer()
        
        button.setGradientBackground(colorOne: Colors.brightOrange, colorTwo: Colors.orange, dir: GradientDirection.leftRight)
//        border.borderColor = UIColor(red: 68/255, green: 105/255, blue: 176/255, alpha: 1).cgColor
//        border.borderWidth = 2
//        border.frame = CGRect(x: 0, y: 0, width: button.frame.width, height: button.frame.height)
//
//        // assign border to the obj (button)
//        button.layer.addSublayer(border)
        
        button.layer.cornerRadius = button.frame.height / 2
        button.layer.masksToBounds = true
        //loginButton.isEnabled = false
        
    }
    
}

