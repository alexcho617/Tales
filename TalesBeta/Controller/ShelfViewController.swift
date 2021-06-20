//
//  SecondViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/19.
//

import UIKit

class ShelfViewController: UIViewController {
    
    var bookGlobal: String = "myBook"
    var idGlobal: String = "myID"
    var userGlobal: String = "myUser"
   
    
    @IBOutlet weak var bookImage1: UIImageView!
    @IBOutlet weak var bookImage2: UIImageView!
    @IBOutlet weak var bookImage3: UIImageView!
    
    
    @IBAction func pick1(_ sender: UIButton) {
        print("picked 1")
    }
    @IBAction func pick2(_ sender: UIButton) {
        print("picked 2")
    }
    @IBAction func pick3(_ sender: UIButton) {
        print("picked 3")
    }
    @IBOutlet weak var select1: UIButton!
    @IBOutlet weak var select2: UIButton!
    @IBOutlet weak var select3: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Shelf Loaded")
        select1.setTitleColor(UIColor.clear, for: .normal)
        select2.setTitleColor(UIColor.clear, for: .normal)
        select3.setTitleColor(UIColor.clear, for: .normal)
        
        if idGlobal == "1" {
            bookImage1.image=#imageLiteral(resourceName: "prince")
            select1.setTitleColor(UIColor.link, for: .normal)
            
        }
        else if idGlobal == "2" {
            bookImage1.image=#imageLiteral(resourceName: "prince")
            bookImage2.image=#imageLiteral(resourceName: "alice")
            select1.setTitleColor(UIColor.link, for: .normal)
            select2.setTitleColor(UIColor.link, for: .normal)


            
        }
        else if idGlobal == "3" {
            bookImage1.image=#imageLiteral(resourceName: "prince")
            bookImage2.image=#imageLiteral(resourceName: "alice")
            bookImage3.image=#imageLiteral(resourceName: "holmes")
            
            select1.setTitleColor(UIColor.link, for: .normal)
            select2.setTitleColor(UIColor.link, for: .normal)
            select3.setTitleColor(UIColor.link, for: .normal)


          
        }

    }
    @IBAction func readPressed(_ sender: UIButton) {
        if idGlobal != "myID" {
                    print("Book Selected")
                    self.performSegue(withIdentifier: "goToRead", sender: self)
                }
                else {
                    print("No Book")
                }
    }
    @IBAction func rankPressed(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://34.239.175.64/createview.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "UserID=" + userGlobal
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
                
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("responseString = \(String(describing: responseString))")

        }
        
        task.resume()
        
        
        print("Rank Selected")
        self.performSegue(withIdentifier: "goToRank", sender: self)
    }
    
   
    @IBAction func addPressed(_ sender: UIButton) {
        print("Plus Pressed")
        self.performSegue(withIdentifier: "goToNewBook", sender: self)
        //self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRead" {
            let destinationVC = segue.destination as! ReadViewController
            destinationVC.bookGlobal = bookGlobal
            destinationVC.idGlobal = idGlobal
        }
        if segue.identifier == "goToNewBook" {
            let destinationVC = segue.destination as! NewBookViewController
            destinationVC.userGlobal = userGlobal
        }
    }
}
