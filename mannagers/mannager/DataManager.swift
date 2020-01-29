//
//  DataManager.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation
import RxSwift

class DataManager {
    //MARK: Singleton
    static let shared = DataManager()
    var userController = UserController()
    var comandController = ComandController()
    //    var groupChatController = GroupChatsController()
    //    var messageController = MessagesController()
    
    private init() {
    }
    func loadComandName(withId id:String) -> Completable{
        let controllers = [comandController.loadCommandName().retry(2)]
        return Completable.merge(controllers)
    }
    func loadUserData(withId id:String) -> Completable {
        
        let controllers = [
            userController.loadUser(for: id).retry(2),
            userController.loadCompanyUsers().retry(2)]
        
        return Completable.merge(controllers)
    }
}
