//
//  ViewController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 03.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        
        style(stl: emailTextField)
        style(stl: passwordTextField)
        style(stl: confirmPasswordTextField)
        buttStyle(stl: signupOutlet)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private let disposeBag = DisposeBag()
    let db = Firestore.firestore()
    var ass = ["ss", "as", "asd", "asdf"]
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signupOutlet: UIButton!
    @IBAction func signupAction(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
            DataManager.shared.userController.registerUser(email: email, password: pass)
                .subscribeOn(MainScheduler())
                .subscribe { [weak self] (event) in
                    switch event {
                    case .error(let error):
                        print(error.localizedDescription)
                    case .completed:
                        if let userId = Auth.auth().currentUser?.uid {
                            DataManager.shared.loadUserData(withId: userId).subscribeOn(MainScheduler())
                                .subscribe(onCompleted: { [weak self] in
                                   let vc = self?.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
                                    vc.modalPresentationStyle = .fullScreen
                                    self?.present(vc, animated: true)
                                    }, onError: { [weak self] (error) in
                                        
                                }).disposed(by: self!.disposeBag)
                        }
                    }
            }.disposed(by: self.disposeBag)
            
        }
        
    }
}


