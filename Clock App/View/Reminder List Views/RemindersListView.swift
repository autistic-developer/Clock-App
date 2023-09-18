//
//  RemindersListView.swift
//  Clock
//
//  Created by Lalit Vinde on 27/07/23.
//

import SwiftUI

struct RemindersListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest<Reminder>(sortDescriptors: [], animation: .spring()) private var models : FetchedResults<Reminder>
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView(showsIndicators: false){
                LazyVStack(spacing:0){
                    ForEach(models){ model in
                        ReminderTile(model: model).padding(.bottom, 10.w)
                    }
                }
            }.padding(.top, 10.w)
            
            VStack{
                Rectangle()
                    .fill(
                        .linearGradient(
                            colors: [Color(hex: 0xEEF0F5), Color(hex: 0xEEF0F5, alpha: 0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 52.w)
                Spacer()
                Rectangle()
                    .fill(
                        .linearGradient(
                            colors: [Color(hex: 0xEEF0F5), Color(hex: 0xEEF0F5, alpha: 0)],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: 52.w)
            }
            .allowsHitTesting(false)
                
        }
    }
}

struct RemindersListView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersListView()
        
    }
}

