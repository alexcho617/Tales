//
//  ReadViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/21.
//

import UIKit

class ReadViewController: UIViewController, ReadModelProtocol {
    
    var feedItems: NSArray = NSArray() //where urlsession stores results
    var selectedBook : ContentsModel = ContentsModel()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Read Loaded")
       
        // Do any additional setup after loading the view.
        let readModel = ReadModel()
        readModel.delegate = self
        readModel.downloadItems()
    }
    
    func itemsDownloaded(items: NSArray) {

        feedItems = items
        let chapterContents = feedItems.componentsJoined(by: " ")
        //print("This is What i got",feedItems,"print from ReadViewController, func itemsDownloaded")
        //contentsLabel.text = chapterContents
        textView.text = chapterContents
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        print("Finished Reading")
        self.dismiss(animated: true, completion: nil)
    }
}
