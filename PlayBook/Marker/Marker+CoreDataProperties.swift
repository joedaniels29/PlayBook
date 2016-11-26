//
//  Marker+CoreDataProperties.swift
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

extension Marker {

    @NSManaged var time: Int64
    @NSManaged var title: String?
    @NSManaged var startTrack: NSManagedObject?

}
