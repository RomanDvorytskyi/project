//
//  EditProfileViewController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 04.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift

class EditProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var completOutlet: UIButton!
    @IBAction func completAction(_ sender: Any) {
      
        if let name = nameTextField.text, let position = surnameTextField.text, let age = positionTextField.text {
            DataManager.shared.userController.updateProfile2(name: name, position: position, age: age)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style(stl: nameTextField)
        style(stl: surnameTextField)
        style(stl: positionTextField)
        buttStyle(stl: completOutlet)
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
