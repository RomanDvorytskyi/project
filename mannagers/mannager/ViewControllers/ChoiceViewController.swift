//
//  ChoiceViewController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 10.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import RxSwift
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage

class ChoiceViewController: UIViewController {
    let db = Firestore.firestore()
    let ref = Database.database().reference()
    
    @IBAction func onlineTextField(_ sender: Any) {
        showSimpleActionSheet()
    }
    func showSimpleActionSheet() {
           let alert = UIAlertController(title: "Update status", message: "Please uodate status", preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Online", style: .default, handler: { (_) in
               DataManager.shared.userController.updateProfile3(status: "Online")
           }))

           alert.addAction(UIAlertAction(title: "Departed", style: .default, handler: { (_) in
               DataManager.shared.userController.updateProfile3(status: "Departed")
           }))

           alert.addAction(UIAlertAction(title: "Offline", style: .default, handler: { (_) in
               DataManager.shared.userController.updateProfile3(status: "Offline")
           }))

           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
               print("User click Dismiss button")
           }))

           self.present(alert, animated: true, completion: {
               print("completion block")
           })
       }
   let storage = Storage.storage()

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editNameOutlet: UITextField!
    @IBOutlet weak var editPositionOutlet: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var editOutlet: UIButton!
    @IBAction func addFoto(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.imageView.image = image
           guard let uid = DataManager.shared.userController.user.id else {return}
            let storageRef = Storage.storage().reference().child("\(uid).jpeg")
            let imgData = image.jpegData(compressionQuality: 0.4)
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            let uploadTask = storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            DataManager.shared.userController.addPhotoUrl(photoUrl: downloadURL.absoluteString)

          }
        }

        }
    }
    @IBAction func exitAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "startViewController") as! startViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc,animated: true)
    }
    func ddd() {
        self.dismiss(animated: true) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: true)
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        
        if let name = editNameOutlet.text, let position = editPositionOutlet.text, let age = textField.text {
            if name != "" && position != "" && age != "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["name" : name, "position" : position, "status" : age], merge: true)
                ddd()
            } else if name != "" && position != "" && age == "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["name" : name, "position" : position], merge: true)
                ddd()
            } else if name != "" && position == "" && age != "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["name" : name, "status" : age], merge: true)
                ddd()
            } else if name == "" && position != "" && age != "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["position" : position, "status" : age], merge: true)
                ddd()
            } else if name != "" && position == "" && age == "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["name" : name], merge: true)
                ddd()
            } else if name == "" && position != "" && age == "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["position" : position], merge: true)
                ddd()
            } else if name == "" && position == "" && age != "" {
                db.collection("Users").document(Auth.auth().currentUser?.uid ?? "")
                    .setData(["status" : age], merge: true)
                ddd()
            } else {
                ddd()
                
            }
        }
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        style(stl: editNameOutlet)
        style(stl: editPositionOutlet)
        style(stl: textField)
        buttStyle(stl: editOutlet)
        
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
