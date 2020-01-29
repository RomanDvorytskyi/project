//
//  GroupChat.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation

class GroupChat: ExpressibleByJSONDictionary {
    var id: String?
    var name: String?
    var description: String?
    var imageUrl: String?
    var Messages: [Messages]?
    
    init() {
        self.name = ""
        self.description = ""
        self.Messages = []
        self.id = ""
        self.imageUrl = ""
    }
}
