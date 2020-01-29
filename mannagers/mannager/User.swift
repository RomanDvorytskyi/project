//
//  User.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//
import FirebaseFirestore
import Foundation

class User:ExpressibleByJSONDictionary  {
    var id: String?
    var position: String?
    var email: String?
    var name: String?
    var status: String?
    var userChatId: [String]?
    var photoUrl: String?
    var CommandId:String?
    var nowOnline:String?
    
    init() {
        self.id = ""
        self.email = ""
        self.name = ""
        self.userChatId = []
        self.photoUrl = ""
        self.position = ""
        self.status = ""
        self.CommandId = ""
        self.nowOnline = ""
    }
}
