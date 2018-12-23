//
//  LoginVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 20/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBtn(button: loginButton)
        configureBtn(button: cancelButton)
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
        
        configureTextField(field: passwordTextField)
        configureTextField(field: emailTextField)
        
    }
    
    func configureTextField(field : UITextField) {
        field.layer.masksToBounds = false
        field.layer.shadowRadius = 3.0
        field.layer.shadowColor = UIColor.black.cgColor
        field.layer.shadowOffset = CGSize(width : 1.0, height : 1.0)
        field.layer.shadowOpacity = 1.0
    }
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
  
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    @IBAction func logginBtnPressed(_ sender: UIButton) {
       
        let url = URL(string: "http://localhost/bd/login.php")!
        let body = "email=\(emailTextField.text!)&password=\(passwordTextField.text!)"
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        // STEP 2. Execute created above request
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                
                do {
                    guard let data = data else {
                        print("Data error")
                        return
                    }
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    guard let parsedJSON = json else {
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200" {
                        
                        currentUser = parsedJSON.mutableCopy() as? NSMutableDictionary
                        UserDefaults.standard.set(currentUser, forKey: "currentUser")
                        UserDefaults.standard.synchronize()
                        self.loadHomeScreen()
                        
                    }
                } catch {
                    print("Invalid JSON")
                }
                
            }
            
            }.resume()
        
    }
    
    
    
}
