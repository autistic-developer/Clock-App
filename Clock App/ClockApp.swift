//
//  ClockApp.swift
//  Clock
//
//  Created by Lalit Vinde on 25/07/23.
//

import SwiftUI
import BackgroundTasks
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "setTodaysAlarm", using: nil) { task in
            self.setTodaysAlarm(task: task as! BGAppRefreshTask)
        }
        return true
    }
    private func setTodaysAlarm(task: BGAppRefreshTask){
        scheduleRefreshForTommarow()
        let fetchRequest = NSFetchRequest<Reminder>(entityName: "Reminder") // Replace "Item" with the name of your
        Task{
            do {
                let fetchedResults = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
                
                for reminder in fetchedResults {
                    await AlarmManager.shared.setAlarm(reminder: reminder)
                    try Task.checkCancellation()
                }
                
            }
            catch let error as NSError {
                print("Fetch error: \(error), \(error.userInfo)")
            }
            
        }
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        UIApplication.shared.beginBackgroundTask{
            self.scheduleRefreshForTommarow()
        }
        
    }
    func scheduleRefreshForTommarow(){
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrowMidNight = Calendar.current.date (byAdding: .day, value: 1, to: today)!
        let request = BGAppRefreshTaskRequest(identifier: "setTodaysAlarm" )
        request.earliestBeginDate = tomorrowMidNight
        try? BGTaskScheduler.shared.submit(request)
    }
}

@main
struct ClockApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var alarmManager = AlarmManager.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
                
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            .environmentObject(alarmManager)
        }
        
    }
   
}
