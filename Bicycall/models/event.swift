//
//  event.swift
//  Bicycall
//
//  Created by Jamil Joo on 8/1/2021.
//

import Foundation

class Event: Codable {
    var event_id: Int
    var event_title: String
    var adress_evt: String
    var date_evt: String
    var time_evt: String
    var user: Int
    
    init(id: Int ,event_title: String ,adress_evt: String ,date_evt: String ,time_evt: String, user: Int ){
        self.event_id = id
        self.event_title = event_title
        self.adress_evt = adress_evt
        self.date_evt = date_evt
        self.time_evt = time_evt
        self.user = user
        
    
    }
}
