//
//  DailyTransactionViewController.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class DailyTransactionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate,NSURLConnectionDataDelegate {
    
    @IBOutlet weak var buSearch: UIButton!
    @IBOutlet weak var buDateFrom: UIButton!
    @IBOutlet weak var buDateTo: UIButton!
    @IBOutlet var radiobutton : [UIButton]!
    @IBOutlet weak var tableDaily : UITableView!
    var VarIsOnRoad :String = "0"
    var VarIsDriverApproved :String = "0"
    var VarIsApproved :String = "0"
    var parser = XMLParser()
    var  noty = 1
    var  noty2 = 2
    var colorRadioOnClick = UIColor(red:0.95, green:0.11, blue:0.25, alpha:1.0)
    var colorRadioUnClick = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
    var suhaib : String = ""
    var date_from :String = "01-01-2017"
    var date_to :String = ""
    var captureElemantName = ""
    var date = Date()
    var formattedData :String{
        get{
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            return formatter.string(from: date)
        }
    }
    var mutablData : NSMutableData?
    var arrayDaily = [DailyTrans]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buSearch.layer.cornerRadius = 5
        buDateTo.setTitle(formattedData, for: .normal)
        date_to = (buDateTo.titleLabel?.text)!
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlPopupclosing), name: Notification.Name(rawValue :"suhaib"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlPopupclosing), name: Notification.Name(rawValue :"suhaib1"), object: nil)

    }
    @objc func handlPopupclosing(notification:Notification){
        if notification.name.rawValue == "suhaib"{
        let date = notification.object as! DatePopupViewController
        buDateFrom.setTitle(date.formattedData, for: .normal)
            date_from = date.formattedData
           // print(date_from)
        };if notification.name.rawValue == "suhaib1"{
            let date = notification.object as! DatePopupViewController
            buDateTo.setTitle(date.formattedData, for: .normal)
            date_to = date.formattedData
            //print(date_to)
        }
    }
    
    var isShecked : Bool?
    @IBAction func starsButoon_tapped(_ sender: UIButton) {
        let bu2 = radiobutton[1]
        let bu1 = radiobutton[0]
        let bu3 = radiobutton[2]
        let bu4 = radiobutton[3]
        if  sender == radiobutton[0] {
            VarIsOnRoad = "0"
            VarIsApproved = "0"
            VarIsDriverApproved = "0"
            sender.setTitle("◉", for: .normal)
            sender.setTitleColor(colorRadioOnClick, for: .normal)
            bu3.setTitle("○", for: .normal)
             bu3.setTitleColor(colorRadioUnClick, for: .normal)
            bu2.setTitle("○", for: .normal)
             bu2.setTitleColor(colorRadioUnClick, for: .normal)
            bu4.setTitle("○", for: .normal)
             bu4.setTitleColor(colorRadioUnClick, for: .normal)
            
        }else if sender == radiobutton[1]
        {
            VarIsOnRoad = "1"
            VarIsApproved = "0"
            VarIsDriverApproved = "0"
            sender.setTitle("◉", for: .normal)
            sender.setTitleColor(colorRadioOnClick, for: .normal)
            bu1.setTitle("○", for: .normal)
            bu1.setTitleColor(colorRadioUnClick, for: .normal)
            bu3.setTitle("○", for: .normal)
            bu3.setTitleColor(colorRadioUnClick, for: .normal)
            bu4.setTitle("○", for: .normal)
            bu4.setTitleColor(colorRadioUnClick, for: .normal)
            
        }else if sender == radiobutton[2]
        {
            VarIsOnRoad = "0"
            VarIsDriverApproved = "1"
            VarIsApproved = "0"
            sender.setTitle("◉", for: .normal)
            sender.setTitleColor(colorRadioOnClick, for: .normal)
            bu1.setTitle("○", for: .normal)
            bu1.setTitleColor(colorRadioUnClick, for: .normal)
            bu2.setTitle("○", for: .normal)
            bu2.setTitleColor(colorRadioUnClick, for: .normal)
            bu4.setTitle("○", for: .normal)
            bu4.setTitleColor(colorRadioUnClick, for: .normal)
        }else {
            VarIsOnRoad = "0"
            VarIsDriverApproved = "0"
            VarIsApproved = "1"
            sender.setTitle("◉", for: .normal)
            sender.setTitleColor(colorRadioOnClick, for: .normal)
            
            bu1.setTitle("○", for: .normal)
            bu1.setTitleColor(colorRadioUnClick, for: .normal)
            bu2.setTitle("○", for: .normal)
            bu2.setTitleColor(colorRadioUnClick, for: .normal)
            bu3.setTitle("○", for: .normal)
            bu3.setTitleColor(colorRadioUnClick, for: .normal)
        }
            }
    
    func loadDailyTrans(){
        date_to = (buDateTo.titleLabel?.text)!
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><GetOrdersReport xmlns='http://37.224.24.195'><VarFromDate>%@</VarFromDate><VarToDate>%@</VarToDate><VarIsOnRoad>%@</VarIsOnRoad><VarIsDriverApproved>%@</VarIsDriverApproved><VarIsApproved>%@</VarIsApproved></GetOrdersReport></soap:Body></soap:Envelope>",date_from,date_to,VarIsOnRoad,VarIsDriverApproved,VarIsApproved)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=GetOrdersReport"
        let url = URL(string: urlString)
        let theRequst = NSMutableURLRequest(url:url!)
        let messageLength = soapMessage.characters.count
        theRequst.addValue("text/xml",forHTTPHeaderField: "Content-Type")
        theRequst.addValue(String(messageLength), forHTTPHeaderField: "Content-Length")
        theRequst.httpMethod = "POST"
        theRequst.httpBody = soapMessage.data(using: String.Encoding.utf8,allowLossyConversion: false)
        if let connection = NSURLConnection(request: theRequst as URLRequest, delegate: self){
            print("hi")
        }else{print("hhh")}
        
        
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        print(error)
    }
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        mutablData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        mutablData?.append(data)
        arrayDaily.removeAll()
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        parser = XMLParser(data: mutablData as! Data)
        parser.delegate = self
        
        if parser.parse(){
            
            tableDaily.reloadData()
        }
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        suhaib = ""
        captureElemantName = elementName
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if captureElemantName == "string"{
            suhaib+=string
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if captureElemantName == "string"{
            let arr = suhaib.components(separatedBy: "&")
            var nuOrder = arr[0]
            var customerName = arr[2]
            var inRoad = arr[4]
            var Driver = arr[6]
            var customer = arr[8]
            arrayDaily.append(DailyTrans(varIsOnRoad:inRoad , Driver:Driver , customer: customer, nuOrder: nuOrder, customerName: customerName))
            print(nuOrder,customerName,inRoad,Driver,customer)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        if arrayDaily.count != 0 {
            var x = arrayDaily.count
            var y = x-1
            var z = x-2
            var r = x-3
            var f = x - 4
            
            arrayDaily.remove(at: y)
            arrayDaily.remove(at: z)
            arrayDaily.remove(at: r)
            arrayDaily.remove(at: f)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let calendar = Calendar.current
        var minDateComponent = calendar.dateComponents([.day,.month,.year], from: Date())
        minDateComponent.day = 1
        minDateComponent.month = 01
        minDateComponent.year = 2017
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let minDate = calendar.date(from: minDateComponent)
        if segue.identifier == "dateFrom"
        {
            
             // Start time
            let vc = segue.destination as! DatePopupViewController
            vc.date = minDate
            vc.not = noty
                    }
        else{
            
            let vc = segue.destination as! DatePopupViewController
            vc.date = minDate
            vc.not = noty2
        }
    }
    
    @IBAction func search(_ sender: Any) {
        
        loadDailyTrans()
    }
}



extension DailyTransactionViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDaily.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DailyTableCellTableViewCell = tableDaily.dequeueReusableCell(withIdentifier: "DailyTableCell",for : indexPath) as! DailyTableCellTableViewCell
        cell.orderNu.text = arrayDaily[indexPath.row].nuOrder
        cell.customerName.text = arrayDaily[indexPath.row].customerName
        if arrayDaily[indexPath.row].varIsOnRoad == "True"{
            cell.inRoade.text = "نعم"
        }else{
            cell.inRoade.text = "لا"
        }
        if arrayDaily[indexPath.row].customer == "True"{
            cell.customer.text = "نعم"
        }else{
            cell.customer.text = "لا"
        }
        if arrayDaily[indexPath.row].Driver == "True"{
            cell.driver.text = "نعم"
        }else{
            cell.driver.text = "لا"
        }
       
        return cell
    }
}
