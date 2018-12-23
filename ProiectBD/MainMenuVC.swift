//
//  MainMenuVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 20/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    @IBOutlet weak var findBooksBtn: UIButton!
    @IBOutlet weak var findBookByAuthorBtn: UIButton!
    @IBOutlet weak var borreowdBooksBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBtn(button: findBooksBtn)
        configureBtn(button: findBookByAuthorBtn)
        configureBtn(button: logoutBtn)
        configureBtn(button: borreowdBooksBtn)
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        emailLabel.text = currentUser!["email"] as! String
        
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
    
    @IBAction func findBookByTitleBtnPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "BookList") as! AuthorVC
        
        viewController.name = ""
        viewController.authorId = "-1"
        
        self.present(viewController, animated: true, completion: nil)

    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "FirstPage") as! ViewController
        
        UserDefaults.standard.removeObject(forKey: "currentUser")
        
        self.present(viewController, animated: true, completion: nil)

    }
}
