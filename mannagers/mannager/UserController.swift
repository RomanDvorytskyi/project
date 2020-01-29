//
//  UserController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import RxSwift


class UserController {
    let db = Firestore.firestore()
    let a = Auth.auth().currentUser
    private let usersVariable = Variable<User>(User())
    private let allUsersVariable = Variable<[User]>([User()])
    
    var userObservable: Observable<User> {
        return usersVariable.asObservable()
    }
    var allUsesrObservable: Observable<[User]> {
        return allUsersVariable.asObservable()
    }
    var user: User {
        return usersVariable.value
    }
    var allUser: [User] {
        return allUsersVariable.value
    }
    
    func editUser(name: String, position: String, status: String) {
        db.collection("Comands").document(user.CommandId ?? "").collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData(["name" : name, "position" : position, "status" : status], merge: true)
    }
    func editUser2(name: String, position: String, status: String) {
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData(["name" : name, "position" : position, "status" : status, "CommandId" : user.CommandId ?? ""], merge: true)
       }
    
    func saveToDataBase() {
        db.collection("Comands").document().collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData(["email" : Auth.auth().currentUser?.email ?? ""])
    }
    
    func saveUserToDataBases() {
        db.collection("Comands").document(user.CommandId ?? "").collection("Users").document(Auth.auth().currentUser?.uid ?? "")
               .setData(["email" : Auth.auth().currentUser?.email ?? ""])
       }
    func saveUserToDataBases2() {
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
        .setData(["email" : Auth.auth().currentUser?.email ?? ""])
    }
    func saveUserToDataBase(email : String) {
        db.collection("Users").document()
            .setData(["email" : Auth.auth().currentUser?.email ?? ""])
    }
    
    func registerUser(email: String, password: String) -> Completable{
        return Completable.create { completable in
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                guard let user = user, error == nil else {
                    if error != nil {
                        completable(.error(error!))
                    } else {
                        completable(.error(NSError(domain: "My App", code: 500, userInfo: [NSLocalizedDescriptionKey: "Sorry, authentication failed! Please try again later."])))
                    }
                    return
                }
                self.updateProfile(email: Auth.auth().currentUser?.email ?? "")
                completable(.completed)
                
            })
            return Disposables.create()
            
        }
        
    }
    
    func updateProfile(email:String) {
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData([ "email": email,
                       "CommandId" : user.CommandId ?? ""], merge: true)
        self.usersVariable.value = user
    }
    
    func updateProfile2(name: String, position: String, age: String) {
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData(["name" : name, "position" : position, "age" : age], merge: true)
        self.usersVariable.value = user
    }
    func updateProfile3(status: String) {
        db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
            .setData(["status" : status], merge: true)
        self.usersVariable.value = user
    }
  
    
    func loadUser(for id:String) -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            self?.db.collection("Users").document(id)
                .addSnapshotListener { documentSnapshot, error in
                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    
                    if let childValue = document.data(),
                        let collectionDictionary = childValue as? [String:Any],
                        let user = User.create(fromDictionary: collectionDictionary) {
                        user.id = id
                        self?.usersVariable.value = user
                    }
                    
                    completable(.completed)
            }
            return Disposables.create()
            
        })
    }
    func loadAllUserss() -> Completable {
        return Completable.create(subscribe: { [weak self] completable in
            self?.db.collection("Comands").document("233").collection("Users")
                .addSnapshotListener  { documentSnapshot, error in
                    guard let documents = documentSnapshot?.documents  else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    var users = [User]()
                    for document in documents {
                        if let user = User.create(fromDictionary:  document.data()) {
                            user.id = document.documentID
                            users.append(user)
                        }
                    }
                    self?.allUsersVariable.value = users
                    completable(.completed)
            }
            return Disposables.create()
        })
    }    
    func loadCompanyUsers ()  -> Completable {
    return Completable.create(subscribe: { [weak self] completable in
        self?.db.collection("Users").whereField("CommandId", isEqualTo: self?.user.CommandId ?? "")
        .addSnapshotListener  { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents  else {
                print("Error fetching document: \(error!)")
                return
            }
            var users = [User]()
            for document in documents {
                if let user = User.create(fromDictionary:  document.data()) {
                    user.id = document.documentID
                    users.append(user)
                }
            }
            self?.allUsersVariable.value = users
            completable(.completed)
        }
        return Disposables.create()
    })
    }
       func addPhotoUrl(photoUrl: String) {
           db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                      .setData(["photoUrl": photoUrl], merge: true)
       }
}
