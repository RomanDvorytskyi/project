//
//  HomeViewController.swift
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
import FirebaseDatabase
import FirebaseStorage
import AlamofireImage



class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var commandName: [CommandName]?
    var nameComand: String = ""
    @IBOutlet weak var comandNameLabel: UILabel!
    @IBOutlet weak var nowOnline: UILabel!
    let currentUser = Auth.auth().currentUser
    var allUsers = DataManager.shared.userController.allUser
    private let disposeBag = DisposeBag()
    var allComands = DataManager.shared.comandController.allComand
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AboutUserViewController") as! AboutUserViewController
        vc.name = allUsers[indexPath.row].name!
        vc.position = allUsers[indexPath.row].position!
        self.present(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        if let icon = DataManager.shared.userController.user.photoUrl , let logoUrl = URL(string: icon){
            cell.imageProfile.af_setImage(withURL: logoUrl)
        } else {
            cell.imageProfile.image = UIImage(named:"oval3")
        }
        
        cell.nameLabel.text = allUsers[indexPath.item].name
        cell.positionLabel.text = allUsers[indexPath.row].position
        cell.status.text = allUsers[indexPath.row].status
        comandNameLabel.text = DataManager.shared.userController.user.CommandId
        if let nowOnlines = cell.status.text  {
            if nowOnlines == "Online" {
                cell.imageStatus.image = UIImage(named: "Oval")
            } else if cell.status.text == "Departed" {
                cell.imageStatus.image = UIImage(named: "oval2")
            } else  {
                cell.imageStatus.image = UIImage(named: "oval3")
            }
            
        }
        cell.layer.borderWidth = 0.1
        cell.layer.cornerRadius = 8
        cell.view.layer.shadowColor = UIColor.black.cgColor
        cell.view.layer.shadowOpacity = 1
        cell.view.layer.shadowOffset = .zero
        cell.view.layer.shadowRadius = 10
        return cell
    }
    
    
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var viewHome: UIView!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var homeSideBar: UIView!
    @IBOutlet weak var qrOutlet: UIButton!
    @IBOutlet weak var homeOutlet: UIButton!
    @IBOutlet weak var profileOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(nameComand)
        subscribe()
        subscribe2()

        number.text = String(allUsers.count)
        
        viewHome.layer.shadowColor = UIColor.black.cgColor
        viewHome.layer.shadowOpacity = 1
        viewHome.layer.shadowOffset = .zero
        viewHome.layer.shadowRadius = 10
        homeSideBar.layer.shadowColor = UIColor.black.cgColor
        homeSideBar.layer.shadowOpacity = 1
        homeSideBar.layer.shadowOffset = .zero
        homeSideBar.layer.shadowRadius = 10
        homeSideBar.layer.cornerRadius = 10
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    func subscribe() {
        let usersObservable = DataManager.shared.userController.allUsesrObservable
        usersObservable.subscribeOn(MainScheduler())
            .subscribe(onNext: { users in
                self.allUsers = users
                self.collection.reloadData()
            }).disposed(by:disposeBag)
    }
    func subscribe2() {
        let comandObservable = DataManager.shared.comandController.allComandsObservable
        comandObservable.subscribeOn(MainScheduler())
            .subscribe(onNext: { users in
                self.allComands = users
                self.collection.reloadData()
            }).disposed(by:disposeBag)
    }
    
    
}
