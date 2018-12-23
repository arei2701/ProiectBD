//
//  AuthorVC.swift
//  ProiectBD
//
//  Created by Andrei Popa on 21/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//

import UIKit

class AuthorVC: UIViewController , UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! FirstCustomCell
        cell.authorNameLabe.text = Array(books.keys)[indexPath.row]
        cell.thumbneilHeight.constant = 0
        cell.bookNameLabel.isHidden = true
        cell.labelHeight.constant = 0
        cell.updateConstraints()

      //  cell.textLabel?.text = Array(books.keys)[indexPath.row]
        return cell
    }
    
    
    let ndg = DispatchGroup()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if name == "" {
            print(books)
            ndg.enter()
            getAuthorsName(authorId: books[Array(books.keys)[indexPath.row]]![0].author_id)
            ndg.notify(queue: .main) {
                self.performSegue(withIdentifier: "goToBook", sender: self)
            }
        } else {
            performSegue(withIdentifier: "goToBook", sender: self)
        }
    }
    
    func getAuthorsName(authorId: String) {
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
                    print(authors)
                    for a in authors {
                        let b = a as! NSDictionary
                        let id = b["id"] as! String
                        let name = b["name"] as! String
                        print(id)
                        print(authorId)
                        if id == authorId {
                            self.auxName = name
                            self.auxAuthorId = authorId
                            break
                        }
                    }
                    
                    self.ndg.leave()
                }
            } catch {
                print("Error")
            }
            
            }.resume()
    }
    
    @IBOutlet weak var tableView: UITableView!
    var books : [String : [(id : String, author_id : String, available : String)]] = [String : [(id : String, author_id : String, available : String)]] ()
    
    @IBOutlet weak var backBtn: UIButton!
    var name : String?
    var authorId : String?
    var auxAuthorId = "-1"
    var auxName = ""
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nim = UINib(nibName: "FirstCustomCell", bundle: nil)
        tableView.register(nim, forCellReuseIdentifier: "customCell")
        nameLabel.text = name!
        //view.setGradientBackground(colorOne: Colors.lightGrey, colorTwo: Colors.black, dir: GradientDirection.topBottom)
        configureBtn(button: backBtn)
        
        tableView.delegate = self
        tableView.dataSource = self
        refresh()
        
        tableView.separatorStyle = .none
        
        // Do any additional setup after loading the view.
    }
    
    func refresh() {
        books = [String : [(id : String, author_id : String, available : String)]] ()
        ndg.enter()
        getBooks()
        ndg.notify(queue: .main) {
            print(self.books)
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BookVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            print(indexPath.row)
            if authorId != "-1" {
                auxName = name!
                auxAuthorId = authorId!
            }
            destinationVC.nrOfCopies = Int(books[Array(books.keys)[indexPath.row]]![0].available)!
            destinationVC.bookName =  Array(books.keys)[indexPath.row]
            destinationVC.bookId =  books[Array(books.keys)[indexPath.row]]![0].id
            destinationVC.p = self
            destinationVC.authorName = auxName
            destinationVC.authorId = auxAuthorId
        }
        
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

    func getBooks() {
        var url : URL? = nil
        if authorId != "-1" {
            print("http://localhost/bd/database_manager.php?method=get_books&author_id=" + authorId!)
            url = URL(string: "http://localhost/bd/database_manager.php?method=get_books&author_id=" + authorId!)!
        } else {
            url = URL(string: "http://localhost/bd/database_manager.php?method=get_books")!
        }
        var request = URLRequest(url: url!)
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
                    let authors = parsedJSON["books"] as! NSArray
                    for a in authors {
                        let b = a as! NSDictionary
                        let id = b["id"] as! String
                        let name = b["name"] as! String
                        let author_id = b["author_id"] as! String
                        let available = b["available"] as! String
                        if available != "0" {
                            if self.books[name] != nil {
                                self.books[name]!.append((id: id, author_id : author_id, available : available))
                                
                            } else {
                                self.books[name] = [(id: id, author_id : author_id, available : available)]
                            }
                            
                        }
                    }
                    
                    self.ndg.leave()
                }
            } catch {
                print("Error")
            }
            
            }.resume()
    }
}
