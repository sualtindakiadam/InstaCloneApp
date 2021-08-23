//
//  SettingsViewController.swift
//  InstaCloneApp
//
//  Created by Semih Kalaycı on 23.08.2021.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    


}
