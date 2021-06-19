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
   
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var bookButton2: UIButton!
    @IBOutlet weak var bookButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Shelf Loaded")
        if idGlobal == "1" {
            bookButton.setImage(#imageLiteral(resourceName: "128-1"), for: .normal)
        }
//image function broken
//        if idGlobal == "2" {
//            bookButton2.setImage(#imageLiteral(resourceName: "128"), for: .normal)
//        }
//        if idGlobal == "3" {
//            bookButton3.setImage(#imageLiteral(resourceName: "128-2"), for: .normal)
//        }
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
    @IBAction func bookPressed(_ sender: UIButton) {
        if idGlobal != "myID" {
            print("Book Selected")
            self.performSegue(withIdentifier: "goToRead", sender: self)
        }
        else {
            print("No Book")
        }
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
