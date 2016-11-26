//
//  Track+CoreDataProperties.swift
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

extension Track {

    @NSManaged var data: NSData?
    @NSManaged var trackName: Int32
    @NSManaged var markers: NSSet?
    @NSManaged var chapters: NSOrderedSet?
    @NSManaged var audioBody: AudioBody?

}
