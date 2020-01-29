//
//  func.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 05.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//
import UIKit
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift


struct CommandName {
    let name: String?
}

var commandName:[CommandName]?

//var ddd = [CommandName(name: )]



func style(stl: UITextField) {
    stl.layer.borderColor = .init(srgbRed: 75/255, green: 151/255, blue: 250/255, alpha: 1)
    stl.layer.cornerRadius = 5
    stl.layer.shadowColor = UIColor.black.cgColor
    stl.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    stl.layer.shadowRadius = 3
    stl.layer.shadowOpacity = 1
    stl.layer.borderWidth = 2
}
func buttStyle(stl: UIButton) {
    stl.layer.cornerRadius = 10
    stl.layer.shadowColor = UIColor.black.cgColor
    stl.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    stl.layer.shadowRadius = 3
    stl.layer.shadowOpacity = 1
}
