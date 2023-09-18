//
//  HomeView.swift
//  Clock
//
//  Created by Lalit Vinde on 01/08/23.
//

import SwiftUI
import EventKit
struct HomeView: View {
    var body: some View {
        ZStack(alignment:.top){
            Color(hex: 0xEEF0F5).ignoresSafeArea()
            VStack(spacing: 0){

                ClockView()
                RemindersListView()
                    .padding(.top, 20.w)
                
                AddButtonView().padding(.vertical, 5.w)

            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    struct Container: View{
        @StateObject var alarmManager = AlarmManager.shared
        var body: some View{
            HomeView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                .environmentObject(alarmManager)
        }
    }
    
    static var previews: some View {
        HomeView()        
    }
}
