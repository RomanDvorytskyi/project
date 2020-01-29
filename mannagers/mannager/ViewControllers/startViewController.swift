//
//  startViewController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 09.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift

class startViewController: UIViewController {
    let disposeBag = DisposeBag()
    var db = Firestore.firestore()
    var allUsers = DataManager.shared.userController.allUser
    var allComands = DataManager.shared.comandController.allComand

    func validateUser () {
        if let userId = Auth.auth().currentUser?.uid {
            DataManager.shared.loadUserData(withId: userId).subscribeOn(MainScheduler())
                .subscribe(onCompleted: { [weak self] in
                    
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.modalPresentationStyle = .fullScreen

                    self?.present(vc, animated: true)
                    
                    }, onError: { [weak self] (error) in
                        
                }).disposed(by: self.disposeBag)
        }
        
    }
  
    func subscribe() {
        let usersObservable = DataManager.shared.userController.allUsesrObservable
        usersObservable.subscribeOn(MainScheduler())
            .subscribe(onNext: { users in
                self.allUsers = users
            }).disposed(by:disposeBag)
    }
    func subscribe2() {
        let comandObservable = DataManager.shared.comandController.allComandsObservable
        comandObservable.subscribeOn(MainScheduler())
            .subscribe(onNext: { comand in
                self.allComands = comand
                
            }).disposed(by:disposeBag)
    }
    func loadComand() {
        if let userId = Auth.auth().currentUser?.uid {

            DataManager.shared.loadComandName(withId: userId).subscribeOn(MainScheduler())
                .subscribe(onCompleted: { [weak self] in


                    }, onError: { [weak self] (error) in

                }).disposed(by: self.disposeBag)
        }
    }
    @IBOutlet weak var newOutlet: UIButton!
    @IBOutlet weak var aboutOutlet: UIButton!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var helloLabelOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        subscribe2()
        let seconds = 1.0
        loadComand()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.validateUser()
            
        }

        buttStyle(stl: newOutlet)
        buttStyle(stl: aboutOutlet)
        buttStyle(stl: loginOutlet)
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
