//
//  ViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login Loaded")
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func logInPressed(_ sender: UIButton) {
        print("Login Pressed")
        self.performSegue(withIdentifier: "goToSecond", sender: self)
    }
    
    
   
}

