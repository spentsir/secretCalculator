//
//  NotesManager.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 6/7/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NotesListTableViewController: UITableViewController {
    
    var Notes = [Note]()
    var displayStrings = [String]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displayStrings = [String]()
        Notes = [Note]()
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            let notes = results as! [Note]
            // list note titles
            for note in notes {
                Notes.append(note)
                displayStrings.append(note.title!)
            }
            
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
        
        tableView.reloadData()
        
    }
    
    //     MARK: Table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Delete row from table
        let id = Notes[indexPath.row].note_id
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            let notes = results as! [Note]
            // list note titles
            for note in notes {
                if note.note_id == id {
                    managedContext.delete(note)
                    try managedContext.save()
                }
            }
            
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
        
        displayStrings.remove(at: indexPath.row)
        Notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayStrings.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as UITableViewCell
        cell.textLabel!.text = displayStrings[indexPath.row]
        return cell
    }
    
    // MARK: Helper functions
    func getSmallestID()-> Int16{
        var ids = [Int16]()
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            let notes = results as! [Note]
            for note in notes {
                ids.append(note.note_id)
            }
        } catch let error as NSError {
            print("fetch or save failed \(error), \(error.userInfo)")
        }
        if ids.count == 0 {
            return(1)
        } else {
            return(ids.max()! + 1)
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! == "showNote" {
            let noteDetailViewController = segue.destination as! NotesDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            noteDetailViewController.note = Notes[selectedIndexPath!.row]
        } else if segue.identifier! == "addNote" {
            
            // add note
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity =  NSEntityDescription.entity(forEntityName: "Note", in:managedContext)
            let newNote = Note(entity: entity!, insertInto: managedContext)
            
            newNote.note_id = getSmallestID()
            newNote.title  = ""
            newNote.text   = ""
            Notes.append(newNote)
            
            // Send new note to view page
            let noteDetailViewController = segue.destination as! NotesDetailViewController
            noteDetailViewController.note = newNote
            
            
            
        }
}
}
