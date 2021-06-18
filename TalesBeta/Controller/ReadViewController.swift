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
    
    var bookGlobal: String = "myBook"
    var idGlobal: String = "myID"
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Read Loaded")
       
        // Do any additional setup after loading the view.
        let readModel = ReadModel()
        
        //readModel.bookGlobal = bookGlobal
        readModel.idGlobal = idGlobal
        
        readModel.delegate = self
        readModel.downloadItems()
        
        bookTitleLabel.text = bookGlobal
        chapterLabel.text = idGlobal
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        let chapterContents = feedItems.componentsJoined(by: " ")
        textView.text = chapterContents
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        print("Finished Reading")
        self.dismiss(animated: true, completion: nil)
    }
}
