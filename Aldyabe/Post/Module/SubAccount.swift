//
//  SubAccount.swift
//  Aldyabe
//
//  Created by nofal on 04/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import Foundation
struct SubAccount {
    var MotionType : String?
    var MotionNum : String?
    var tranDebt : String?
    var tranCredit : String?
    var MotionDate : String?
    var MotionNumType : String?
    var sumTranDebt : String?
    var sumTranCredit : String?
    var sumTotalBal : String?
   
    var MotionSumation : String?
    init(MotionType : String, MotionNum : String,tranDebt : String,tranCredit : String,MotionDate : String,MotionNumType : String,sumTranDebt : String,sumTranCredit : String,sumTotalBal : String,MotionSumation : String){
        self.MotionType = MotionType
        self.MotionNum = MotionNum
        self.tranDebt = tranDebt
        self.tranCredit = tranCredit
        self.MotionNumType = MotionNumType
        self.sumTranDebt = sumTranDebt
        self.sumTranCredit = sumTranCredit
        self.sumTotalBal = sumTotalBal
        self.MotionDate = MotionDate
        self.MotionSumation = MotionType
    }
    
}
