//
//  RegisterVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 20/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureBtn(button: cancelBtn)
        configureBtn(button: registerBtn)
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        configureTextField(textField: emailTextField)
        configureTextField(textField: passwordTextField)
        
    }
    
    func configureTextField(textField : UITextField) {
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.
        
        //To apply corner radius
        textField.layer.cornerRadius = textField.frame.size.height / 2
        
        //To apply border
        textField.layer.borderWidth = 0.25
       // textField.layer.borderColor = UIColor.white.cgColor
        
        //To apply Shadow
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 3.0
        //textField.layer.shadowOffset = CGSize.zero // Use any CGSize
        //textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 3)
        textField.layer.shadowColor = UIColor.black.cgColor //Any dark color
        //To apply padding
        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always
//        field.layer.masksToBounds = false
//        field.layer.shadowRadius = 3.0
//        field.layer.shadowColor = UIColor.black.cgColor
//        field.layer.shadowOffset = CGSize(width : 1.0, height : 1.0)
//        field.layer.shadowOpacity = 1.0
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
    
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuVC") as! MainMenuVC
        self.present(loggedInViewController, animated: true, completion: nil)
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func registerBtnClicked(_ sender: UIButton) {
    
        let url = URL(string: "http://localhost/bd/register.php")!
        let body = "email=\(emailTextField.text!.lowercased())&password=\(passwordTextField.text!)&phone_number=\(phoneNumberTextField.text!)"
        var request = URLRequest(url: url)
        request.httpBody = body.data(using: .utf8)
        request.httpMethod = "POST"
        
        // STEP 2. Execute created above request
        
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // access helper class
            DispatchQueue.main.async {
            // error
                if error != nil {
                   print("Server Error" +  error!.localizedDescription)
                    return
                }
                // fetch JSON if no error
                do {
                    
                    // save mode of casting data
                    guard let data = data else {
                        print("Data Error" +  error!.localizedDescription)
                        return
                    }
                    
                    // fetching all JSON received from the server
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
                    
                    // save mode of casting JSON
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
                   print("Error")
                }
            }
            }.resume()
        
        

        
    }
}
