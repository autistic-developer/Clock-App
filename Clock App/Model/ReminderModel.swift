//
//  ReminderModel.swift
//  Clock
//
//  Created by Lalit Vinde on 27/07/23.
//

import Foundation

struct ReminderModel : Identifiable, Hashable{
    let id:String = UUID().uuidString
    var toggle:Bool=true
    var date:Date = .now
    var days:[Bool]=[true, true, true, true, true, true, true]
    
}


