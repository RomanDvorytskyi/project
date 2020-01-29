//
//  Comannds.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 10.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import FirebaseFirestore
import Foundation

class Comands:ExpressibleByJSONDictionary  {
    var Name: String?
    var id: String?
    
    init() {
      
        self.Name = ""
        self.id = ""
    }
}
