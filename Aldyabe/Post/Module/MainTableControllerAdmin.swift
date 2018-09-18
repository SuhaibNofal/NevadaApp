//
//  MainTableControllerAdmin.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct MainTableControllerAdmin {
    var customerName : String?
    var NumberOFAccount : String?
    var customerNumber : String?
    init(customerName :String, NumberOFAccount : String, customerNumber : String) {
        self.customerName = customerName
        self.NumberOFAccount = NumberOFAccount
        self.customerNumber = customerNumber
    }
}
