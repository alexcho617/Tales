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
    @IBOutlet weak var UserID: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Gender: UITextField!
    @IBOutlet weak var Age: UITextField!
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        let request = NSMutableURLRequest(url: NSURL(string: "http://34.239.175.64/signup.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "UserID=\(UserID.text!)&Name=\(Name.text!)&Gender=\(Gender.text!)&Age=\(Age.text!)"
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
