//
//  DailyTrans.swift
//  Aldyabe
//
//  Created by nofal on 29/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct DailyTrans {
    var varIsOnRoad :String?
    var Driver :String?
    var customer : String?
    var nuOrder : String?
    var customerName :String?
    init(varIsOnRoad:String,Driver:String,customer :String,nuOrder:String,customerName:String){
        self.varIsOnRoad = varIsOnRoad
        self.Driver = Driver
        self.customer = customer
        self.nuOrder = nuOrder
        self.customerName = customerName

    }
}
