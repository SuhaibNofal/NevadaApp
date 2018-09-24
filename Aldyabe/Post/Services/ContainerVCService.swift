//
//  ContainerVCService.swift
//  Aldyabe
//
//  Created by nofal on 23/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class ContainerVCService: UIViewController,NSURLConnectionDataDelegate,XMLParserDelegate {
     var CustomerNum : String?
     var captureData = ""
     var mutableData :NSMutableData?
     var parser = XMLParser()
     var suhaib : String = ""
     var ArrayCustomerInfo = [String]()
     var CustomerNameAr : String = ""
     var CustomerNameEn : String = ""
     var AccountNumber : String = ""
     var Country : String = ""
     var City : String = ""
     var AccStartBalance : String = ""
     var AccDate : String = ""
     var AccTranType : String = ""
     var AccPhoneNum : String = ""
     var AccPoBox : String = ""
     var AccAdress : String = ""
     var Email : String = ""
     var AccCusMax : String = ""
     var AccChekMax : String = ""
     var AccMaxOk : String = ""
     var iisMaxOk = false
    var Child : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
            }
    func loadCustomerInfo( Custmer : String) ->Bool{
        let soapMessage = String(format :"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getCustomerInfo xmlns='http://37.224.24.195'><C_No>%@</C_No></getCustomerInfo></soap:Body></soap:Envelope>",CustomerNum!)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getCustomerInfo"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        let connection = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        connection?.start()
        if connection != nil{
            return true
        }else{print("dd")}
        return true
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
        //var xmldata = NSString(data: mutableData! as Data, encoding: String.Encoding.utf8.rawValue)
        //print("xml is \(xmldata)")
        parser = XMLParser(data : mutableData! as Data )
        parser.delegate = self
        if parser.parse(){
            
        }
    }
    
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        
    }
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict:[String : String] = [:])
    {
        suhaib = ""
        
        captureData = elementName
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {   if captureData == "string"{
        suhaib+=string
        }
        
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "string"{
            ArrayCustomerInfo.append(suhaib)
            //print(ArrayCustomerInfo)
        }
        
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {
        
        
        
        
    }
    
    }
