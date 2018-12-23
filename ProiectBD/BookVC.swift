//
//  BookVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 22/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class BookVC: UIViewController {

    var authorId : String?
    var bookName : String?
    var bookId : String?
    var authorName : String?
    var nrOfCopies = 0
    var p : AuthorVC?
    
    @IBOutlet weak var nrOfCopiesLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var loanBookBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        configureBtn(button: backBtn)
        configureBtn(button: loanBookBtn)
        // Do any additional setup after loading the view.
        
        bookNameLabel.text = bookName!
        authorNameLabel.text = authorName!
        nrOfCopiesLabel.text = String(nrOfCopies) + " available"
        
        
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
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        p!.refresh()
        self.dismiss(animated: true, completion: nil)
    }
    var dbg = DispatchGroup()

    @IBAction func loanBtnPressed(_ sender: Any) {
        let id = currentUser!["id"]! as! String
        
        if nrOfCopies <= 0 {
            return
        }
        let url = URL(string: "http://localhost/bd/database_manager.php")!
        
        var request = URLRequest(url: url)
        let body = "method=loan_book&user_id=" + id + "&book_id=" + bookId!
       
        request.httpBody = body.data(using: .utf8)
       
        request.httpMethod = "POST"
        dbg.enter()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
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
                    print(parsedJSON)
                    self.nrOfCopies -= 1
                    self.dbg.leave()
                }
                    
            
            } catch {
                print("Error")
            }
            
            }.resume()
        dbg.notify(queue: .main) {
            
            self.nrOfCopiesLabel.text = String(self.nrOfCopies) + " available"
            if self.nrOfCopies == 0{
                self.loanBookBtn.setTitle("Add me to the waiting list", for: .normal)
                
            }
        }
    }
    
}
