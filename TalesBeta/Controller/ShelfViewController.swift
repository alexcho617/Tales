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
    
   
    @IBOutlet weak var bookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Shelf Loaded")
        bookButton.setImage(#imageLiteral(resourceName: "64"), for: .normal)
        // Do any additional setup after loading the view.
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
    @IBAction func checkButton(_ sender: UIButton) {
        print("Selected Book:",bookGlobal)
        print("Selected ID:",idGlobal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRead" {
            let destinationVC = segue.destination as! ReadViewController
            destinationVC.bookGlobal = bookGlobal
            destinationVC.idGlobal = idGlobal
        }
    }
}
