//
//  DatePopupViewController.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {
    var not :Int?
    @IBOutlet weak var buSaveDate: UIButton!
    @IBOutlet weak var pickerview: UIDatePicker!
    @IBOutlet weak var laSelectDate: UILabel!
    var showTimePicker : Bool = false
    var date :Date?
    var formattedData :String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            formatter.locale = Locale(identifier: "en")
            return formatter.string(from: pickerview.date)
        }
    }
    var formattedTime :String{
        get{
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "en")
            return formatter.string(from: pickerview.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerview.minimumDate = date
    }
    
    
    @IBAction func SaveDate_dismissPop(_ sender: Any) {
        if not == 1{
            NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib"), object: self)}
        if not == 2{
        NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib1"), object: self)
        }
        if not == 3{
            NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib"), object: self)
        }
        if not == 4{
            NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib1"), object: self)
        }
        if not == 5{
            NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib2"), object: self)
        }
        if not == 6{
            NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib3"), object: self)
        }
        dismiss(animated: true)
    }
    

    
    

  

}
