//
//  SignupViewController.swift
//  TalesBeta
//
//  Created by alex on 2021/06/19.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Signup Loaded")
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLogIn", sender: self)
   
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
