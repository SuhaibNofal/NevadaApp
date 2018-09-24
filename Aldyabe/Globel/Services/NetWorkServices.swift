//
//  NetWorkServices.swift
//  Aldyabe
//
//  Created by nofal on 19/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class NetWorkServices:UIViewController,XMLParserDelegate,NSURLConnectionDataDelegate  {
    var captureElemantName = ""
    var mutablData = NSMutableData()
    var parser = XMLParser()
    var arrayDaily = [DailyTrans]()
    
    
   
    func loadData(soapMessage : String , url:String ){
    let urlString = url
    let url = URL(string: urlString)
    let theRequst = NSMutableURLRequest(url:url!)
    let messageLength = soapMessage.characters.count
    theRequst.addValue("text/xml",forHTTPHeaderField: "Content-Type")
    theRequst.addValue(String(messageLength), forHTTPHeaderField: "Content-Length")
    theRequst.httpMethod = "POST"
    theRequst.httpBody = soapMessage.data(using: String.Encoding.utf8,allowLossyConversion: false)
    let connection = NSURLConnection(request: theRequst as URLRequest, delegate: self)
    connection?.start()
    
}
    func connection(_ connection: NSURLConnection, didFailWithError error: Error)
    {
        print(error)
        print("no connection")
    }
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse)
    {
       mutablData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data)
    {
        mutablData.append(data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection)
    {
        //var xmldata = NSString(data: mutableData! as Data, encoding: String.Encoding.utf8.rawValue)
        //print("xml is \(xmldata)")
        parser = XMLParser(data : mutablData as Data )
        parser.delegate = self
        if parser.parse(){
            
        }
    }
func parserDidStartDocument(_ parser: XMLParser) {
    
}
func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
}
func parser(_ parser: XMLParser, foundCharacters string: String) {
    
}
func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
}
func parserDidEndDocument(_ parser: XMLParser) {
    
}
}


