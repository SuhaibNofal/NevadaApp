//
//  Child3_DeletionInformationVC.swift
//  Aldyabe
//
//  Created by nofal on 10/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Child3_DeletionInformationVC: UIViewController ,XMLParserDelegate,NSURLConnectionDataDelegate{
@IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var laCountryData: UILabel!
    @IBOutlet weak var laCityData: UILabel!
    @IBOutlet weak var laPhoneData: UILabel!
    @IBOutlet weak var laOfficeData: UILabel!
    @IBOutlet weak var laAddressData: UILabel!
    @IBOutlet weak var laEmailData: UILabel!
    var CustomerNum :String?
    var mutableData :NSMutableData?
    var parser = XMLParser()
    var ArrayCustomerInfo = [String]()
    var captureData = ""
    var suhaib = ""
    
    var Country : String = ""
    var City : String = ""
    var AccPhoneNum : String = ""
    var AccPoBox : String = ""
    var AccAdress : String = ""
    var Email : String = ""
    override func viewDidLoad() {
        ImageGradint(imageback: imageBack).backimage1()
        loadCustomerInfo()
        super.viewDidLoad()

    }
    func loadCustomerInfo() ->Bool{
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
    {
        if captureData == "string"
        {
            suhaib+=string
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "string"{
            ArrayCustomerInfo.append(suhaib)
            
        }
        
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {
        laCountryData.text = ArrayCustomerInfo[12]
        laCityData.text = ArrayCustomerInfo[11]
        laPhoneData.text = ArrayCustomerInfo [3]
        if ArrayCustomerInfo[8] == ""{
            laEmailData.text = "-"
        }else{
            laEmailData.text = ArrayCustomerInfo[8]
        }
        if ArrayCustomerInfo[4] == ""{
            laOfficeData.text = "-"
        }else{
            laEmailData.text = ArrayCustomerInfo[4]
        }
        if ArrayCustomerInfo[5] == ""{
            laAddressData.text = "-"
        }else{
            laAddressData.text = ArrayCustomerInfo[5]
        }
        
                
    }

}
extension Child3_DeletionInformationVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "معلومات العميل")
    }
}
