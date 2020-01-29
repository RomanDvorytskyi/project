//
//  createTeamViewController.swift
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
import FirebaseDatabase


class createTeamViewController: UIViewController {
    let db = Firestore.firestore()
    
    let ref =  Database.database().reference()
    
    @IBOutlet weak var createTeamTextField: UITextField!
    
    @IBOutlet weak var createTeamOutlet: UIButton!
    
    private let disposeBag = DisposeBag()
    
    var allComands = DataManager.shared.comandController.allComand
    
    var namess = [String]()
    
    @IBAction func createTeamAction(_ sender: Any) {
        present(loadingAlertController, animated: true, completion: nil)
        if let id = createTeamTextField.text {
            DataManager.shared.comandController.checkTeamID2(id: id).subscribeOn(MainScheduler())
                .subscribe(onCompleted: { [weak self] in
                    loadingAlertController.dismiss(animated: true, completion: {
                        self?.db.collection("Comands").document(id).setData(["id" : id])
                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        let vc2 = self?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        vc2.commandName = commandName
                        vc2.nameComand = id
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: true)
                        
                        print("ss")
                    })
                    }, onError: { [weak self] (error) in
                        loadingAlertController.dismiss(animated: true, completion: {
                            self?.showErrorAlert(message:"Team name is not found")
                        })
                }).disposed(by: disposeBag)
        } else {
            loadingAlertController.dismiss(animated: true, completion: {
                self.showErrorAlert(message:"Team name is not found")
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttStyle(stl: createTeamOutlet)
        style(stl: createTeamTextField)
    }
}
