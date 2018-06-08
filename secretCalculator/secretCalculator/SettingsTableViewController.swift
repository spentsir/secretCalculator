//
//  SettingsTableViewController.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/8/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name:"Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "PasscodeSetter")
        self.present(resultViewController, animated:true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = "Password:"
        cell.detailTextLabel?.text = "\(String(describing: savedData.string(forKey: "Passcode")))"
        return cell
    }
    
    

}
