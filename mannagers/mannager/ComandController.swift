//
//  UserController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift



class ComandController {
    let db = Firestore.firestore()
    let a = Auth.auth().currentUser

    private let allComandNameVariable = Variable<[Comands]>([Comands()])
     
    var allComandsObservable: Observable<[Comands]> {
        return allComandNameVariable.asObservable()
    }
    var allComand: [Comands] {
        return allComandNameVariable.value
    }
    
    func loadCommandName() -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            self?.db.collection("Comands")
                .addSnapshotListener  { documentSnapshot, error in
                    guard let documents = documentSnapshot?.documents  else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    var comandss = [Comands]()
                    for document in documents {
                        if let comand = Comands.create(fromDictionary:  document.data()) {
                            comand.Name = document.documentID
                            comandss.append(comand)
                        }
                    }
                    self?.allComandNameVariable.value = comandss
                    completable(.completed)
            }
            return Disposables.create()
        })
    }
    
    func checkTeamID(id:String) -> Completable {
        return Completable.create {  completable in
            self.db.collection("Comands").document(id).getDocument { (document, error) in
                if let document = document, document.exists {
                    completable(.completed)
                    DataManager.shared.userController.user.CommandId = id
                } else {
                    if error != nil{
                        completable(.error(error!))
                    } else {
                        completable(.error(NSError(domain: "My App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error"])))
                    }
                }
            }
            return Disposables.create()
        }
    }
    func checkTeamID2(id:String) -> Completable {
        return Completable.create {  completable in
            self.db.collection("Comands").document(id).getDocument { (document, error) in
                if let document = document, document.exists {
                    if error != nil{
                        completable(.error(error!))
                    } else {
                        completable(.error(NSError(domain: "My App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Error"])))
                    }
                    
                } else {
                    completable(.completed)
                    DataManager.shared.userController.user.CommandId = id
                }
            }
            return Disposables.create()
        }
    }
}

