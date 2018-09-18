//
//  LastTransActionViewController.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class LastTransActionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,XMLParserDelegate,NSURLConnectionDataDelegate {
    
    
    @IBOutlet weak var imgbackground: UIImageView!
    @IBOutlet weak var noTranse: UILabel!
    var mutableData: NSMutableData?
    var captureElemantName = ""
    var suhaib : String = ""
    @IBOutlet weak var lastTransTable: UITableView!
    @IBOutlet weak var custmerName: UILabel!
    @IBOutlet weak var custmerAccount: UILabel!
    @IBOutlet weak var typeOfMovment: UILabel!
    @IBOutlet weak var numberOfMovment: UILabel!
    @IBOutlet weak var dateOfMovment: UILabel!
    var name:String?
    var number :String?
    var TranTypeNo :String?
    var TranNo:String?
    var isAdmin = ""
    var arrayLast = [LastTransActionParameter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let background = ImageGradint(imageback: imgbackground)
        
        lastTransTable.dataSource = self
        lastTransTable.delegate = self
        
        custmerAccount.text = number
        custmerName.text = name
        if isAdmin == "2"
        {
            loadLastTransfrom()
        }else {
            loadLastTrans()
        }
        
        
    }
   
    func loadLastTrans(){
        let lsst = number
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getLastTrans xmlns='http://37.224.24.195'><Acc_no>%@</Acc_no></getLastTrans></soap:Body></soap:Envelope>",lsst!)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getLastTrans"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        let connection = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        connection?.start()
  
    }
    func loadLastTransfrom(){
        
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getTrans xmlns='http://37.224.24.195'><TranTypeNo>%@</TranTypeNo><TranNo>%@</TranNo></getTrans></soap:Body></soap:Envelope>",TranTypeNo!,TranNo!)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getTrans"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        let connection = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        connection?.start()
        
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        
        
    }
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        mutableData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        mutableData?.append(data)
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        let parser = XMLParser(data: mutableData! as Data)
        parser.delegate = self
        if parser.parse(){
            lastTransTable.reloadData()
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
        if elementName == "string"
        {
            let arr = suhaib.components(separatedBy: "&")
            var tranNo = arr[2]
            var tranType = arr[0]
            var TranDate = arr[4]
            var acctName = arr[10]
            //var maden = arr[6]
            var fCredit = Float(arr[6])
            var maden = ""
            if fCredit == 0{
                maden = "0"
            }else{
               let x = String(format: "%.2f", fCredit!)
                
               // let endIndex = x.index(x.endIndex, offsetBy: -2)
                
                //let truncated = x.substring(to: endIndex)
                maden = "(\(x))"
            }
            var daen1 = Float(arr[8])
            var daen = ""
            if daen1 == 0{
                daen = "0"
            }else{
                let x = String(format: "%.2f", daen1!)
                daen = "(\(x))"
            }
            var declaration = arr[12]
            arrayLast.append(LastTransActionParameter(tranType: tranType,tranNo:tranNo,TranDate:TranDate,maden: maden,daen:daen,acctName: acctName,declaration:declaration))
            
            //print(arr)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        if arrayLast.count>0 {
            typeOfMovment.text = arrayLast[0].tranType
            numberOfMovment.text = arrayLast[0].tranNo
            dateOfMovment.text = arrayLast[0].TranDate
        }else{
            noTranse.layer.backgroundColor = UIColor.brown.cgColor
            noTranse.isHidden = false
            lastTransTable.isHidden = true
            
        }
        
        print("parsing end")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableLastTransCell =  lastTransTable.dequeueReusableCell(withIdentifier: "movmentCell", for: indexPath)as!TableLastTransCell
        cell.daen.text = arrayLast[indexPath.row].daen
        cell.maden.text = arrayLast[indexPath.row].maden
        cell.nameAccount.text = arrayLast[indexPath.row].acctName
        cell.report.text = arrayLast[indexPath.row].declaration
        
        return cell
    }

}
