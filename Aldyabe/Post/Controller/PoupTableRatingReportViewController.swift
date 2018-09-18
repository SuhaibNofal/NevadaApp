//
//  PoupTableRatingReportViewController.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class PoupTableRatingReportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate,NSURLConnectionDataDelegate {

    var custom = ["جميع العملاء","محطة الجمعان","محطة الوفاق"]
    @IBOutlet weak var Popupview: UIView!
    @IBOutlet weak var tableView: UITableView!
    var titleRowSelect :String?
    var customerAccount: String?
    var mutableData: NSMutableData?
    var parser = XMLParser()
    var suhaib : String = ""
    var captureData :String = ""
    var CustomerData = Array<arrayAdmin>()
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomerData.append(arrayAdmin(nu: "0", Name: "جميع العملاء", account: "0"))
        loadCustomer()
    }
    func loadCustomer(){
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getAllCustomer xmlns='http://37.224.24.195' /></soap:Body></soap:Envelope>")
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?"
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
            tableView.reloadData()
        }
    }
    func parserDidStartDocument(_ parser: XMLParser)
    {
        
    }
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict:[String : String] = [:])
    {    suhaib = ""
        
        captureData = elementName
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {    if captureData == "string"{
        suhaib+=string
        }
        
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "string"{
            let arr = suhaib.components(separatedBy: "&")
            //print(arr)
            var nu = arr[0]
            var Name = arr[2]
            var account = arr[4]
            
            CustomerData.append(arrayAdmin(nu: nu,Name: Name,account: account))
        }
        
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {    if CustomerData.count != 0 {
        
        
    }
    else{
        print("no data found")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != Popupview {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleRowSelect = CustomerData[indexPath.row].Name
        customerAccount = CustomerData[indexPath.row].account
        
        NotificationCenter.default.post(name: Notification.Name(rawValue :"suhaib2"), object: self)
        dismiss(animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PopupTableRatingCell = tableView.dequeueReusableCell(withIdentifier: "cellpopup", for: indexPath) as! PopupTableRatingCell
        cell.popupcelltable.text = CustomerData[indexPath.row].Name
        return cell
                
    }

}
