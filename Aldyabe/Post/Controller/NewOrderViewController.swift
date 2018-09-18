//
//  NewOrderViewController.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {

    @IBOutlet weak var buSelectDate: UIButton!
    @IBOutlet weak var tableSelectSubject: UITableView!
    @IBOutlet weak var laBookingDate: UILabel!
    @IBOutlet weak var buStationStop: UIButton!
    @IBOutlet weak var tableStationStop: UITableView!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var buSelectSubject: UIButton!
    let date = Date()
    var arr = [NewOrderDropDown]()
    
    override func viewDidLoad() {
        arr.append(NewOrderDropDown(CellInTable: "بنزين95"))
        arr.append(NewOrderDropDown(CellInTable: "95بنزين"))
        arr.append(NewOrderDropDown(CellInTable: "90بنزين"))
        arr.append(NewOrderDropDown(CellInTable: "بنزين"))
        arr.append(NewOrderDropDown(CellInTable: "بنزين"))
        arr.append(NewOrderDropDown(CellInTable: "ديزل"))
    var imagegradint = ImageGradint(imageback: imageBackground)
    //imagegradint.backimage()
    NotificationCenter.default.addObserver(self, selector: #selector(handlPopupDateclosing), name: Notification.Name(rawValue :"suhaib"), object: nil)
        setCurruntDate()
        
    super.viewDidLoad()
        
    }
    @objc func handlPopupDateclosing(notification:Notification){
        
        let date = notification.object as! DatePopupViewController
        buSelectDate.setTitle(date.formattedData, for: .normal)
        buSelectDate.setTitle(date.formattedData, for: .normal)
        
        
    }
    @IBAction func buHandelSelectSubject(_ sender: Any) {
        tableSelectSubject.isHidden = !tableSelectSubject.isHidden
        if !tableStationStop.isHidden{
            tableStationStop.isHidden = true
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != tableSelectSubject {
            tableSelectSubject.isHidden = true
        }
        
    }
    
    @IBAction func buHandleStationStop(_ sender: Any) {
        tableStationStop.isHidden = !tableStationStop.isHidden
        
    }

    func setCurruntDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        laBookingDate.text = result
        
    }
}
extension NewOrderViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var celltoReturn = UITableViewCell()
        if tableView == tableSelectSubject{
            let cell : NewOrderDropDownCell = tableView.dequeueReusableCell(withIdentifier: "SelectSubject", for: indexPath) as!NewOrderDropDownCell
            cell.LaSelectSubject.text = arr[indexPath.row].CellInTable
        celltoReturn = cell
        }
        if tableView == tableStationStop {
            let cell : NewOrderDropDownCell = tableView.dequeueReusableCell(withIdentifier: "StationStop", for: indexPath) as!NewOrderDropDownCell
            cell.laSelectStationStop.text = arr[indexPath.row].CellInTable
celltoReturn = cell
            
        }
        return celltoReturn
    }
    
    
}

