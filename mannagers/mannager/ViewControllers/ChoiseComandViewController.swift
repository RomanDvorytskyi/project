//
//  ChoiseComandViewController.swift
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
import FirebaseDatabase

class ChoiseComandViewController: UIViewController {
    private let disposeBag = DisposeBag()
    @IBOutlet weak var choiseTextField: UITextField!
    @IBOutlet weak var choiseOutlet: UIButton!
    
    @IBAction func choiseAction(_ sender: Any) {
            present(loadingAlertController, animated: true, completion: nil)
            if let id =  choiseTextField.text, id != "" {
                DataManager.shared.comandController.checkTeamID(id: id).subscribeOn(MainScheduler())
                    .subscribe(onCompleted: { [weak self] in
                        loadingAlertController.dismiss(animated: true, completion: {
                            self?.goToSignUp()})
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
    
    func goToSignUp() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.present(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style(stl: choiseTextField)
        buttStyle(stl: choiseOutlet)
    }

}
