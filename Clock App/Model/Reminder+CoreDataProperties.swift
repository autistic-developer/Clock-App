//
//  Reminder+CoreDataProperties.swift
//  Clock
//
//  Created by Lalit Vinde on 05/08/23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var date: Date
    @NSManaged public var days: Int16
    @NSManaged public var toggle: Bool

}

extension Reminder : Identifiable {

}
