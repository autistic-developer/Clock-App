//
//  Reminder+CoreDataClass.swift
//  Clock
//
//  Created by Lalit Vinde on 04/08/23.
//
//

import Foundation
import CoreData

@objc(Reminder)
public class Reminder: NSManagedObject {
    
    convenience init(context: NSManagedObjectContext, date:Date){
        
        self.init(context: context)
        self.date=date
        PersistenceController.save()
    }
    public override func didChangeValue(forKey key: String) {
        PersistenceController.save()
        Task{
            await AlarmManager.shared.setAlarm(reminder:self)
        }
    }
   
}
