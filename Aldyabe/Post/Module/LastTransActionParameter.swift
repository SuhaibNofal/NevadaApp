//
//  LastTransActionParameter.swift
//  Aldyabe
//
//  Created by nofal on 28/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct LastTransActionParameter{
    //var AcctNo :String?
    var tranNo : String?
    var tranType : String?
    var TranDate :String?
    var acctName : String?
    var maden : String?
    var daen :String?
    var declaration :String?
    init(tranType :String,tranNo:String,TranDate :String,maden:String?,daen:String?,acctName:String?,declaration:String?){
        
         self.tranNo = tranNo
         self.tranType = tranType
         self.TranDate = TranDate
         self.acctName = acctName
         self.maden = maden
         self.daen = daen
         self.declaration = declaration
        
    }
}
