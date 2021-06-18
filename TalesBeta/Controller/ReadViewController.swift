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
    var chapterGlobal: Int = 5
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Read Loaded")
       
        // Do any additional setup after loading the view.
        let readModel = ReadModel()
        
        readModel.idGlobal = idGlobal
        
        readModel.delegate = self
        readModel.downloadItems()
        //view
        bookTitleLabel.text = bookGlobal
        chapterLabel.text = "Ch."+String(chapterGlobal)
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        var chapterContents = ContentsModel()
        //print("feedItems.count:",feedItems.count)
        print("Chapter:",chapterGlobal)
        chapterContents = feedItems[chapterGlobal-1] as! ContentsModel //cast from any to ContentsModel -1 for index correction
        //print(chapterContents.contents ?? "Empty")
        
        let strContents = chapterContents.contents //cast as a String
        textView.text = strContents
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        print("Finished Reading")
        self.dismiss(animated: true, completion: nil)
    }
}
