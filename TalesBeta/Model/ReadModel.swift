//
//  ReadModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/12.
//  This is ReadModel used in ReadViewController

import Foundation

//protocol ReadModelProtocol: class {
protocol ReadModelProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}


class ReadModel: NSObject, URLSessionDataDelegate {
    var ipAddress: String
    var idGlobal: String
    var fileType: String
    
    override init() {
        ipAddress = "http://34.239.175.64/book"
        idGlobal = "1"
        fileType = ".php"
    }
   
    weak var delegate: ReadModelProtocol!
    var data = Data()
    func downloadItems() {
            let urlPath = ipAddress+idGlobal+fileType
            //print("urlPath in ReadModel downloadItems:", urlPath)
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
            let pages = NSMutableArray() //array to store all books
            //print("books array created")
            for i in 0 ..< jsonResult.count
            {
                //print(jsonResult[i])//testing
                jsonElement = jsonResult[i] as! NSDictionary
                let page = ContentsModel() //single book object
                //the following insures none of the JsonElement values are nil through optional binding
                if let chapterID = jsonElement["ChapterID"] as? String,
                    let index = jsonElement["idx"] as? String,
                    let contents = jsonElement["contents"] as? String
                {
                    page.chapterID = chapterID
                    page.index = index
                    page.contents = contents
                }
                pages.add(page) //add a book entry to books
            }
        //passed back to newbook viewcontroller
        DispatchQueue.main.async(execute: { () -> Void in self.delegate.itemsDownloaded(items: pages)})
        }
}

