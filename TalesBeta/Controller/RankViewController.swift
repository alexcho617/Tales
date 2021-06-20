//
//  RankViewController.swift
//  TalesBeta
//
//  Created by alex on 2021/06/19.
//

import UIKit

class RankViewController: UIViewController, RankModelProtocol {
    
    
    var feedItems: NSArray = NSArray() //where urlsession stores results

    @IBOutlet weak var rank1: UILabel!
    @IBOutlet weak var rank2: UILabel!
    @IBOutlet weak var rank3: UILabel!
    
    @IBAction func backPressed(_ sender: UIButton) {
        print("Rnank Loaded")
        self.dismiss(animated: false, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let rankModel = RankModel()
        rankModel.delegate = self
        rankModel.downloadItems()
        // Do any additional setup after loading the view.
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        var firstRank = RankerModel()
        var secondRank = RankerModel()
        var thirdRank = RankerModel()
        
        
        firstRank = feedItems[0] as! RankerModel
        secondRank = feedItems[1] as! RankerModel
        thirdRank = feedItems[2] as! RankerModel
        
        rank1.text = ("1st: " + firstRank.name! + ", " + firstRank.views! + "views")
        rank2.text = ("2nd: " + secondRank.name! + ", " + secondRank.views! + "views")
        rank3.text = ("3rd: " + thirdRank.name! + ", " + thirdRank.views! + "views")

//        print("Rank 1")
//        print(firstRank.name ?? "myRankerName")
//        print(firstRank.views ?? "myView")
//
//        print("Rank 2")
//        print(secondRank.name ?? "myRankerName")
//        print(secondRank.views ?? "myView")
//
//        print("Rank 3")
//        print(thirdRank.name ?? "myRankerName")
//        print(thirdRank.views ?? "myView")
        
    }


}
