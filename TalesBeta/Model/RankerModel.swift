//
//  RankerModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/20.
//
//  ranker model used in RankModel.swift

import Foundation

class RankerModel: NSObject {
    
    //properties
    var name: String?
    var views: String?
    //empty constructor
    override init()
    {
        
    }
    
    //construct with @ID, @name parameters
    init(name: String, views: String) {
        self.name = name
        self.views = views
    }
    
    //prints object's current state
    override var description: String {
        return "views: \(views!), BookName: \(name!)"
    }
}
