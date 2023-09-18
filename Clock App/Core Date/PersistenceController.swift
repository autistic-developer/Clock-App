//
//  PersistenceController.swift
//  Clock
//
//  Created by Lalit Vinde on 03/08/23.
//

import Foundation
import CoreData
import SwiftUI

struct PersistenceController{
    static let shared : PersistenceController = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "ReminderModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError?{
                fatalError("\(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext{
        PersistenceController.shared.container.viewContext
    }
    static func save(){
        withAnimation(.spring()){
            do{
                try PersistenceController.shared.container.viewContext.save()
                
            }
            catch{
                fatalError("\(error)")
            }
        }
    }
}
