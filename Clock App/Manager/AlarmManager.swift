//
//  AlarmManager.swift
//  Clock
//
//  Created by Lalit Vinde on 04/08/23.
//

import Foundation
import UserNotifications
import UIKit

actor AlarmManager : NSObject, UNUserNotificationCenterDelegate, ObservableObject{
    
    static let shared = AlarmManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    private let dateFormatter = DateFormatter()
    @MainActor @Published var isGranted:Bool = false
    
    override init(){
        super.init()
        notificationCenter.delegate=self
        dateFormatter.dateFormat = "HH:mm"
        
    }
    // MARK: delegate userNotificationCenter
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
    
    // MARK: request authorization
    func requestAuthorization(){
        Task{
            let setting = await notificationCenter.notificationSettings()
            if setting.authorizationStatus == .notDetermined{
                requestAccess()
            }
            else if setting.authorizationStatus  == .denied{
                await openSettings()
            }
        }
    }
    
    // MARK: request access
    private func requestAccess() {
        Task{
            do{
                try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
                await setIsGrantedStatus()
            }
            catch{
                fatalError("\(error)")
            }
        }
    }
    
    // MARK: open settings
    @MainActor private func openSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString){
            if UIApplication.shared.canOpenURL(url){
                Task{
                    await UIApplication.shared.open(url)
                }
            }
        }
        
    }
    
    // MARK: set is granted
    @MainActor func setIsGrantedStatus(){
        Task{
            let setting = await notificationCenter.notificationSettings()
            isGranted = setting.authorizationStatus == .authorized
        }
    }
    
    // MARK: set alarm
    func setAlarm(reminder:Reminder, repeats:Bool=false) async {
        let day:Int16 = 1 << ( (Calendar.current.component(.weekday, from:Date.now) + 5) % 7 )
        Task{
            if await isGranted{
                if (reminder.days & day) != 0 && reminder.toggle{
                    let content = UNMutableNotificationContent()
                    content.title = "Wake Up"
                    content.sound = UNNotificationSound(named: .init("default.mp4"))
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: reminder.date), repeats: repeats)
                    let request = UNNotificationRequest(identifier: dateFormatter.string(from: reminder.date), content: content, trigger: trigger)
                    do{
                        try await notificationCenter.add(request)
                    }
                    catch{
                        fatalError("\(error)")
                    }
                }
                else{
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: [dateFormatter.string(from: reminder.date)])
                }
            }
            
        }
    }
    func deleteAlarm(date:Date){
        Task{
            if await isGranted{
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [dateFormatter.string(from: date)])
            }
        }
    }
    
}
