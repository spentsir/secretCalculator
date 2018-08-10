//
//  NoteController.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 8/9/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import CoreData

class NoteController {
    
    // CRUD Fuctions
    // Create
    static func add(noteWithName title: String, text: String) {
        let _ = Note(title: title, text: text)
        saveData()
    }
    
    // Update
    static func update(note: Note, newTitle: String, newText: String) {
        note.title = newTitle
        note.text = newText
        saveData()
    }
    
    // Remove
    static func remove(note: Note) {
        note.managedObjectContext?.delete(note)
        saveData()
    }
    
    private static func saveData() {
        do {
            try CoreDataStack.context.save()
            print("Saving...")
        } catch let error {
            print("Error saving data!: \(error.localizedDescription)")
        }
    }
}
