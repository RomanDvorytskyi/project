//
//  Messages.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation

class Messages: ExpressibleByJSONDictionary {
    var id: String?
    var userId: String?
    var text: String?
    var date: Int?
    var userName: String?
    
    init() {
        self.userId = ""
        self.text = ""
        self.date = 0
        self.userName = ""
        self.id = ""
    }
}
