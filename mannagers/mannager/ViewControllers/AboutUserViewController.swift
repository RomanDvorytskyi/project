//
//  AboutUserViewController.swift
//  mannager
//
//  Created by Roman Dvoritskiy on 10.12.2019.
//  Copyright © 2019 Roman Dvoritskiy. All rights reserved.
//

import UIKit

class AboutUserViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var avarageLabel: UILabel!
    var name: String = ""
    var position: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        positionLabel.text = position
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
