//
//  HomeModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/10.
//

import Foundation

//protocol HomeModelProtocol: class {
protocol HomeModelProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}


//class HomeModel: NSObject, NSURLSessionDataDelegate { //older version
class HomeModel: NSObject, URLSessionDataDelegate {

    //properties
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://3.235.224.194/service.php" //this will be changed to the path where service.php lives

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
            let books = NSMutableArray() //array to store all books
            //print("books array created")
           
            for i in 0 ..< jsonResult.count
            {
                //print(jsonResult[i],"HomeModel.swift")//testing
                jsonElement = jsonResult[i] as! NSDictionary
                
                let book = BookModel() //single book object
                
                //the following insures none of the JsonElement values are nil through optional binding
                if let name = jsonElement["BookName"] as? String,
                    let id = jsonElement["BookID"] as? String
                {
                    book.name = name
                    book.id = id
                }
                books.add(book) //add a book entry to books
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.delegate.itemsDownloaded(items: books) //passed back to newbok viewcontroller
                
            })
        }
}

