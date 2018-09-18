//
//  TableRatingReport.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct TableRating {
    var numOfOrder : String?
    var nameCustomer : String?
    var rating : String?
    var Notes : String?
    var delay : String?
    var QuantityNotMatching : String?
    var MaterialNotMatching : String?
    init(NumOfOrder : String,NameCustomer : String ,Rating : String,Notes : String,delay : String,QuantityNotMatching : String,MaterialNotMatching : String) {
        self.numOfOrder = NumOfOrder
        self.nameCustomer = NameCustomer
        self.rating = Rating
        self.Notes = Notes
        self.delay = delay
        self.QuantityNotMatching = QuantityNotMatching
        self.MaterialNotMatching = MaterialNotMatching
}
}
