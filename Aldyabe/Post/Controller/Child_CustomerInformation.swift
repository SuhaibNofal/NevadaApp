//
//  Child_CustomerInformation.swift
//  Aldyabe
//
//  Created by nofal on 10/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class Child_CustomerInformation: UIViewController,XMLParserDelegate,NSURLConnectionDataDelegate {
    @IBOutlet weak var imageBack: UIImageView!
    var CustomerNum :String?
    var mutableData :NSMutableData?
    var parser = XMLParser()
    var ArrayCustomerInfo = [String]()
    var captureData = ""
    var suhaib = ""
    
    var AccountNumber :String = ""
    var EndBalance :String = ""
    var DateCreateAccount :String = ""
    var StartBalance :String = ""
    var TransType :String = ""
    var CustomerNameArabic : String = ""
    var CustomerNameEnglish : String = ""
    @IBOutlet weak var laAccountNumber: UILabel!
    @IBOutlet weak var laEndBalance: UILabel!
    @IBOutlet weak var lDateCreateAccount: UILabel!
    @IBOutlet weak var laStartBalance: UILabel!
    @IBOutlet weak var laTransType: UILabel!
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
        laAccountNumber.text = ArrayCustomerInfo[6]
        var totalVale1 : Double = Double(ArrayCustomerInfo[0])!
        var tranCredit = ""
        if (totalVale1 < 0){
            totalVale1 = totalVale1 * -1
            laEndBalance.textColor = .red
            tranCredit = String(format: "%.2f", totalVale1)
            laEndBalance.text = "(\(tranCredit))"
        }else{laEndBalance.text = ArrayCustomerInfo[0]}
        
        lDateCreateAccount.text = ArrayCustomerInfo[7]
        laStartBalance.text = ArrayCustomerInfo[13]
        if (ArrayCustomerInfo[14] == "1")
        {
            laTransType.text = "مدين"
        }else if (ArrayCustomerInfo[11] == "2"){
            laTransType.text = "دائن"
        }
        else {
            laTransType.text = "مدين ودائن "
        }
    }

}
extension Child_CustomerInformation : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "معلومات الحساب")
    }

    }

