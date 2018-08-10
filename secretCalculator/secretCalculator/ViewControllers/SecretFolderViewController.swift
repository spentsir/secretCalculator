//
//  SecretFolderViewController.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/7/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit
import CoreData

let savedData = UserDefaults.standard

class SecretFolderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func lockApp(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "Calculator")
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
