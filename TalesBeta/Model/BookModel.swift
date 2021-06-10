//
//  BookModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/10.
//

import Foundation

class BookModel: NSObject {
    
    //properties
    var id: String?
    var name: String?
    //empty constructor
    override init()
    {
        
    }
    
    //construct with @ID, @name parameters
    init(name: String, id: String) {
        self.id = id
        self.name = name
    }
    
    //prints object's current state
    override var description: String {
        return "ID: \(id!), Name: \(name!)"
    }
}
