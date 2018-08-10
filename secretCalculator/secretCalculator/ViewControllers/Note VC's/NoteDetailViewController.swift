//
//  NotesDetailViewController.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/7/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import UIKit
import CoreData

class NotesDetailViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text = note?.title
        contentTextField.text = note?.text
        
        self.addDoneButtonOnKeyboard()
        titleTextField.autocapitalizationType = .sentences
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        note?.title = titleTextField.text!
        note?.text = contentTextField.text
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // save note
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    // Keyboard "Done" Button
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.titleTextField.inputAccessoryView = doneToolbar
        self.contentTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.titleTextField.resignFirstResponder()
        self.contentTextField.resignFirstResponder()
    }
}
