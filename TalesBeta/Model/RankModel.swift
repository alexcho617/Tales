//
//  RankModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/20.
//
//  Rank is for the RankViewController

import Foundation

//protocol HomeModelProtocol: class {
protocol RankModelProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}



class RankModel: NSObject, URLSessionDataDelegate {
    //properties
    weak var delegate: RankModelProtocol!
    var data = Data()
    let urlPath: String = "http://34.239.175.64/rank.php" //this will be changed to the path where service.php lives
    func downloadItems() {
            let url: URL = URL(string: urlPath)!
            let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
            let task = defaultSession.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("Failed to download data")
                }else {
                    //print("Data downloaded")
                    self.parseJSON(data!)
                }
            }
            task.resume()
        }
    
    func parseJSON(_ data:Data) {
            //print("Parse JSOON function called")
            var jsonResult = NSArray()
            do{
                jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            } catch let error as NSError {
                print(error)
            }
        
            var jsonElement = NSDictionary()
            let rankers = NSMutableArray() //array to store all books
            //print("books array created")
            for i in 0 ..< jsonResult.count
            {
                //print(jsonResult[i],"HomeModel.swift")//debuggin testing
                jsonElement = jsonResult[i] as! NSDictionary
                let ranker = RankerModel() //single book object
                //the following insures none of the JsonElement values are nil through optional binding
                if let name = jsonElement["BookName"] as? String,
                    let views = jsonElement["views"] as? String
                {
                    ranker.name = name
                    ranker.views = views
                }
                rankers.add(ranker) //add a book entry to books
            }
        //passed back to newbok viewcontroller
        DispatchQueue.main.async(execute: { () -> Void in self.delegate.itemsDownloaded(items: rankers)})
        }
}

