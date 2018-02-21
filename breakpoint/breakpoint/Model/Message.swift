//
//  Message.swift
//  breakpoint
//
//  Created by Emmanuel Olivo on 21/02/18.
//  Copyright © 2018 Con Dos Emes. All rights reserved.
//

import Foundation

class Message {
    
    // Declare private variables for encapsulation
    private var _content : String
    private var _senderId: String
    
    
    // initializer
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
    
    // get data from private variables
    var content : String {
        return _content
    }
    
    var senderId : String {
        return _senderId
    }
    
    
    
    
    
    
}
