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
    var bookGlobal: String = "myBook"
    var idGlobal: String = "myID"
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Set selected book to var
        selectedBook = feedItems[indexPath.row] as! BookModel
        //send data to shelfview controller
        //print("Selected Book:",selectedBook.name!,"BookID:",selectedBook.id!)
        bookGlobal = selectedBook.name! //global variable
        idGlobal = selectedBook.id! //global variable
        /*
         seague prep to send data back?
         */
        self.performSegue(withIdentifier: "goBackToShelf", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goBackToShelf" {
            let destinationVC = segue.destination as! ShelfViewController
            destinationVC.bookGlobal = bookGlobal
            destinationVC.idGlobal = idGlobal
        }
    }
}
