//
//  Chapter+CoreDataProperties.swift
//  
//
//  Created by Joseph Daniels on 12/26/15.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Chapter {

    @NSManaged var number: Int64
    @NSManaged var tracks: NSOrderedSet?
    @NSManaged var section: Sections?
    @NSManaged var audioBody: AudioBody?

}
