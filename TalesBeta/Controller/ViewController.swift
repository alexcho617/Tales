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

    @IBOutlet weak var UserID: UITextField!
    @IBOutlet weak var Name: UITextField!
    
    @IBAction func logInPressed(_ sender: UIButton) {
        print("Login Pressed")
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://34.239.175.64/login.php")! as URL)
        request.httpMethod = "POST"
        
        let postString = "UserID=\(UserID.text!)&Name=\(Name.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { [self]
            data, response, error in
                
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            print("response = \(String(describing: response))")
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            print("responseString = \(String(describing: responseString))")
            
            if String(describing: responseString) == "Optional(1)"{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToSecond", sender: self)
                }
                print("successed\n");
            }
            else{
                print("failed\n");
            }
        }
        
        task.resume()
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSignUp", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecond" {
            let destinationVC = segue.destination as! ShelfViewController
            destinationVC.userGlobal = UserID.text ?? "myUser"
        }
    }
}

