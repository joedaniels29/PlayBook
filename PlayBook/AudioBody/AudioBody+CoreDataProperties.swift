//
//  AudioBody+CoreDataProperties.swift
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

extension AudioBody {

    @NSManaged var coverPicture: NSData?
    @NSManaged var name: String?
    @NSManaged var secondPicture: NSData?
    @NSManaged var author: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var bookmarks: NSSet?
    @NSManaged var currentLocation: PlayHead?
    @NSManaged var sections: NSOrderedSet?
    @NSManaged var tracks: NSOrderedSet?

}
