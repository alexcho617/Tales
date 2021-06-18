//
//  ContentsModel.swift
//  TalesBeta
//
//  Created by alex on 2021/06/12.
//  Contents model used in ReadModel.

import Foundation

class ContentsModel: NSObject {
    
    //properties
    var chapterID: String?
    var index: String?
    var contents: String?
    //empty constructor
    override init()
    {
        
    }
    
    //construct with @ID, @name parameters
    init(chapterID: String, index: String, contents: String) {
        self.chapterID = chapterID
        self.index = index
        self.contents = contents
    }
    
    //prints object's current state
    override var description: String {
        return "chapterID: \(chapterID!), index: \(index!), contents: \(contents!)"
    }
}
