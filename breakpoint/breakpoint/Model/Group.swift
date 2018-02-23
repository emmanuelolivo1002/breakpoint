//
//  Group.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 22/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import Foundation

class Group {
    
    private var _groupTitle: String
    private var _groupDescription: String
    private var _groupId: String
    private var _memberCount: Int
    private var _members: [String]
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDescription: String {
        return _groupDescription
    }
    
    var groupId: String {
        return _groupId
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String, id: String, members: [String], memberCount: Int) {
        self._groupTitle = title
        self._groupDescription = description
        self._groupId = id
        self._members = members
        self._memberCount = memberCount
        
    }
    
    
    
}
