//
//  Note+Convenience.swift
//  secretCalculator
//
//  Created by Spencer Cawley on 8/9/18.
//  Copyright © 2018 Spencer Cawley. All rights reserved.
//

import CoreData

extension Note {
    convenience init(title: String, text: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.text = text
    }
}
