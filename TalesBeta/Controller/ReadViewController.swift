//
//  ReadViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/21.
//

import UIKit

class ReadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Read Loaded")
        // Do any additional setup after loading the view.
    }
    

    @IBAction func donePressed(_ sender: UIButton) {
        print("Finished Reading")
        self.dismiss(animated: true, completion: nil)
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
