//
//  NewBookViewController.swift
//  TalesBeta
//
//  Created by Alex Cho on 2021/05/21.
//

import UIKit
class NewBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    //Properties
    
    var feedItems: NSArray = NSArray()
    var selectedLocation : BookModel = BookModel()
    
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("NewBook Loaded")
        // Do any additional setup after loading the view.
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        print("Done Pressed")
        self.dismiss(animated: true, completion: nil)
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
        
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        // Get the book to be shown
        let item: BookModel = feedItems[indexPath.row] as! BookModel
        // Get references to labels of cell, using book name
        myCell.textLabel!.text = item.name
        
        return myCell
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
