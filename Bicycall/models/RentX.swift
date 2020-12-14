//
//  RentX.swift
//  Bicycall
//
//  Created by Fares Ben Slama on 14/12/2020.
//

import Foundation

class RentX {
    
    var location_id: Int
    var datelocation:String
    var adresselocation: String
    var user_id: Int
    var bike_id: Int
    
    var hours: String
    var totalprice: String
    
    
    init(id: Int ,date: String , adresse: String , user: Int , bike: Int, hours: String , totalprice: String ){
        self.location_id = id
        self.datelocation = date
        self.adresselocation = adresse
        self.user_id = user
        self.bike_id = bike
        self.hours = hours
        self.totalprice = totalprice
    }
    
    
    
    
}
