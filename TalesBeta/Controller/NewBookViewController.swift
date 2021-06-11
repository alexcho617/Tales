//
//  NewBookViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/21.
//

import UIKit
class NewBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    //Properties
    
    var feedItems: NSArray = NSArray() //where urlsession stores results
    var selectedBook : BookModel = BookModel()
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    
    func itemsDownloaded(items: NSArray) {

        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        return feedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        selectedBook = feedItems[indexPath.row] as! BookModel
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the book to be shown
        let item: BookModel = feedItems[indexPath.row] as! BookModel
        // Get references to labels of cell, using book name
        myCell.textLabel!.text = item.name
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to var
        selectedBook = feedItems[indexPath.row] as! BookModel
        print("Selected Book:",selectedBook.name!,"BookID:",selectedBook.id!)
        self.dismiss(animated: true, completion: nil)
        
    }
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//            // Get reference to the destination view controller
//            let detailVC  = segue.destination as! DetailViewController
//            // Set the property to the selected location so when the view for
//            // detail view controller loads, it can access that property to get the feeditem obj
//            detailVC.selectedBook = selectedBook
//        }


}
