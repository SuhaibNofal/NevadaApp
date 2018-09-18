//
//  TableFollowOrder.swift
//  Aldyabe
//
//  Created by nofal on 15/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct TableFollowOrder {
    var orderNu : String
    var orderName : String
    var orderQuantity : String
    var stopPosition : String
    init(orderNu : String,orderName : String,orderQuantity : String,stopPosition : String) {
        self.orderNu = orderNu
        self.orderName = orderName
        self.orderQuantity = orderQuantity
        self.stopPosition = stopPosition
    }
    
}
