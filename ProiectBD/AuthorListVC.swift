//
//  AuthorListVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 21/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class AuthorListVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FirstCustomCell

        
        cell.authorNameLabe.text = authors[indexPath.row].name
        cell.bookNameLabel.isHidden = true
        cell.labelHeight.constant = 0
        
        cell.thumbnailImage.image = UIImage(named: "5abc881cb2505.png")
        cell.updateConstraints()
        //cell.textLabel?.text = authors[indexPath.row].name

        return cell
    }
    let ndg = DispatchGroup()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToAuthor", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! AuthorVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath.row)
            print(authors[indexPath.row].name)
            destinationVC.name = authors[indexPath.row].name
            destinationVC.authorId = authors[indexPath.row].id
        }
       
    }
    var authors : [(id : String, name : String)] = [(id : String, name : String)]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        let nim = UINib(nibName: "FirstCustomCell", bundle: nil)
        tableView.register(nim, forCellReuseIdentifier: "customCell")
        configureBtn(button: backBtn)
        // Do any additional setup after loading the view.
       // view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        ndg.enter()
        getAuthors()
        ndg.notify(queue: .main) {
            print(self.authors)
            self.tableView.reloadData()
        }
        tableView.separatorStyle = .none
    }
    
    func getAuthors(){
        let url = URL(string: "http://localhost/bd/database_manager.php?method=get_authors")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                        self.ndg.leave()
                        return
                    }
                    
                    // fetching all JSON received from the server
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary
            
                    // save mode of casting JSON
                    guard let parsedJSON = json else {
                        self.ndg.leave()
                        return
                    }
                    
                    if parsedJSON["status"] as! String == "200" {
                        let authors = parsedJSON["authors"] as! NSArray
                        for a in authors {
                            let b = a as! NSDictionary
                            let id = b["id"] as! String
                            let name = b["name"] as! String
                            print(id)
                            self.authors.append((id: id, name: name))
                        }
                        
                        self.ndg.leave()
                    }
                } catch {
                    print("Error")
                }
            
        }.resume()
            
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
        self.dismiss(animated: true, completion: nil)
    }
}
