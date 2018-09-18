//
//  MainCustomerViewController.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class MainCustomerViewController: UIViewController {

    @IBOutlet weak var AccName: UILabel!
    @IBOutlet weak var AccNo: UILabel!
    @IBOutlet weak var AccStartBalance: UILabel!
    @IBOutlet weak var AccCity: UILabel!
    @IBOutlet weak var AccDate: UILabel!
    @IBOutlet weak var AccEndBalance: UILabel!
    @IBOutlet var buMainCustomer: [UIButton]!
    var ara :[String] = []
    override func viewDidLoad() {
        
        buStyleRadeus(button: buMainCustomer)
        
        AccName.text = ara[1]
        AccNo.text = ara[0]
        AccCity.text = ara[2]
        AccDate.text = ara[3]
        AccStartBalance.text = ara[4]
        AccEndBalance.text = ara[5]
        
        super.viewDidLoad()
    }
  
    func buStyleRadeus(button : [UIButton]){
        button.forEach{(button)in
        button.layer.cornerRadius = 5
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        
        
        
    }
}
