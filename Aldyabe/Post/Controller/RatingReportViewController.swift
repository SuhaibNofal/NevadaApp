//
//  RatingReportViewController.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class RatingReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,RatingCellDelegate,XMLParserDelegate,NSURLConnectionDataDelegate {
var parser = XMLParser()
    var mutableData: NSMutableData?
    var suhaib : String = ""
    var captureData :String = ""
    @IBOutlet  var checkbu: [UIButton]!
    @IBOutlet weak var SelectCustomer: UIButton!
    @IBOutlet weak var buDateFrom: UIButton!
    var select : String = "0"
    var select1 : String = "0"
    var select2 : String = "0"
    var bu_data_from = ""
    var bu_data_to = ""
    var tag : String = "0"
    var date = Date()
    var x = 0
    var ratingArray = Array<TableRating>()
    var accountNumber :String = "0"
    var notyRating = 3
    var notyRating1 = 4
    
    @IBOutlet weak var buDateTo: UIButton!
    @IBOutlet var starsButton: [UIButton]!
    let currentDate = Date()
    
    @IBOutlet weak var tableRating: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectcurrentdate()
        
       
        NotificationCenter.default.addObserver(self, selector: #selector(handlPopupDateclosing), name: Notification.Name(rawValue :"suhaib"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlPopupDateclosing), name: Notification.Name(rawValue :"suhaib1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlPopupDateclosing), name: Notification.Name(rawValue :"suhaib2"), object: nil)
    }
    
    @objc func handlPopupDateclosing(notification:Notification){
        if notification.name.rawValue == "suhaib2"{
        let custm = notification.object as! PoupTableRatingReportViewController
        SelectCustomer.setTitle(custm.titleRowSelect, for: .normal)
            accountNumber = custm.customerAccount!
            print(accountNumber)
        }
        else if notification.name.rawValue == "suhaib"{
            let date = notification.object as! DatePopupViewController
            buDateFrom.setTitle(date.formattedData, for: .normal)
            bu_data_from = date.formattedData
        }
        else if notification.name.rawValue == "suhaib1"{
            let date = notification.object as! DatePopupViewController
            buDateTo.setTitle(date.formattedData, for: .normal)
            bu_data_to = date.formattedData
        }
        
    }
    
    @IBAction func starsButoon_tapped(_ sender: UIButton) {
        let tag1 = sender.tag
        tag = String(sender.tag + 1)
        for button in starsButton{
            if button.tag <= tag1{
                button.setTitle("✭", for: .normal)
                
            }else{
                button.setTitle("✩", for: .normal)
            }
        }
    }
    
    
    
    
    @IBAction func select_checkbox(_ sender: UIButton) {
        
        if sender.tag == 0 && select == "0" {
        sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_015"), for: UIControlState.normal)
            select = "1"
        }else if sender.tag == 0 && select == "1"{
            sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_000"), for: UIControlState.normal)
            select = "0"
        }
        else if sender.tag == 1 && select1 == "0" {
            sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_015"), for: UIControlState.normal)
            select1 = "1"
        }else if sender.tag == 1 && select1 == "1"{
            sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_000"), for: UIControlState.normal)
            select1 = "0"
            
        }else if sender.tag == 2 && select2 == "0" {
            sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_015"), for: UIControlState.normal)
            select2 = "1"
        }else if sender.tag == 2 && select2 == "1"{
            sender.setBackgroundImage(UIImage(named: "abc_btn_check_to_on_mtrl_000"), for: UIControlState.normal)
            select2 = "0"
        }
    }
    
    @IBAction func buSearchRating(_ sender: Any) {
        loadDataToMainAdmin()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateRatingFrom"{
            let vc = segue.destination as! DatePopupViewController
            vc.not = notyRating     
        }else if segue.identifier == "dateRatingTo"{
            let vc = segue.destination as! DatePopupViewController
            vc.not = notyRating1
        }
    }
        func selectcurrentdate()
    {
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        let myStringafd = formater.string(from: Date())
        buDateTo.setTitle(myStringafd, for: .normal)
        bu_data_from = "01-08-2018"
        bu_data_to = myStringafd
    }
    
    func loadDataToMainAdmin() {
        
        
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getComplaints xmlns='http://37.224.24.195'><VarCustID>%@</VarCustID><VarRate>%@</VarRate><VarIsLate>%@</VarIsLate><VarIsQtyNotGood>%@</VarIsQtyNotGood><VarIsItemNotGood>%@</VarIsItemNotGood><VarFromDate>%@</VarFromDate><VarToDate>%@</VarToDate></getComplaints></soap:Body></soap:Envelope>",accountNumber,tag,select,select1,select2,bu_data_from,bu_data_to)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getComplaints"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        if let connection = NSURLConnection(request: theRequest as URLRequest, delegate: self){
            print("jjj")
            connection.start()
        }
        
        
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error)
    {
        print(error)
        print("no connection")
    }
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse)
    {
        mutableData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data)
    {
        mutableData?.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection)
    {
        
        parser = XMLParser(data : mutableData! as Data )
        parser.delegate = self
        if parser.parse(){
            print("fff")
            tableRating.reloadData()
        }else{
            print("No Data")
        }
    }
    
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        ratingArray.removeAll()
    }
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict:[String : String] = [:])
    {    suhaib = ""
        
        captureData = elementName
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        suhaib+=string
        
        
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "string"{
            let arr = suhaib.components(separatedBy: "&")
            print(arr)
            let numOfOrder = arr[0]
            let Name = arr[2]
            let Rating = arr[4]
            let Note = arr[6]
            let delay = arr[8]
            let Quantity = arr[10]
            let Matereal = arr[12]
            ratingArray.append(TableRating(NumOfOrder: numOfOrder, NameCustomer: Name, Rating: Rating, Notes: Note, delay: delay, QuantityNotMatching: Quantity, MaterialNotMatching: Matereal))
        }
        
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {

    }
    
    
   
}

extension RatingReportViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell :TableRatingReportCell = tableRating.dequeueReusableCell(withIdentifier: "cellRating", for: indexPath) as! TableRatingReportCell
        cell.cellDelegate = self
        cell.NumOfOrder.text = ratingArray[indexPath.row].numOfOrder
        cell.NameCustomer.text = ratingArray[indexPath.row].nameCustomer
        cell.Rating.text = ratingArray[indexPath.row].rating
        cell.information.tag = indexPath.row
        return cell
    }
    
    func didPressButton(_ tag: Int) {
        
        let story :UIStoryboard = UIStoryboard(name : "Main",bundle : nil)
        let maincustomer = story.instantiateViewController(withIdentifier: "PopNotesRatingVC") as! PopNotesRatingVC
        maincustomer.dilay = ratingArray[tag].delay
        maincustomer.Notes = ratingArray[tag].Notes
        maincustomer.Qantitiy = ratingArray[tag].QuantityNotMatching
        maincustomer.Matereal = ratingArray[tag].MaterialNotMatching
        
        self.present(maincustomer, animated: true, completion: nil)
        x = tag
        var y = ratingArray[tag].delay
        //print(y)
        //print(x)
    }
}




