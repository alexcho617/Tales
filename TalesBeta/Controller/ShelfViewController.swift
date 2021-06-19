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
    @IBOutlet weak var bookButton2: UIButton!
    @IBOutlet weak var bookButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Shelf Loaded")
        if idGlobal == "1" {
            bookButton.setImage(#imageLiteral(resourceName: "128-1"), for: .normal)
        }
        if idGlobal == "2" {
            bookButton2.setImage(#imageLiteral(resourceName: "128"), for: .normal)
        }
        if idGlobal == "3" {
            bookButton3.setImage(#imageLiteral(resourceName: "128-2"), for: .normal)
        }
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
    }
}
