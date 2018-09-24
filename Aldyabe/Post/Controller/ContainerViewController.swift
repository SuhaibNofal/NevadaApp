//
//  ContainerViewController.swift
//  Aldyabe
//
//  Created by nofal on 17/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ContainerViewController: ButtonBarPagerTabStripViewController ,XMLParserDelegate,NSURLConnectionDataDelegate {
    let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
    var CustomerNum : String = ""
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
    var ChildType = ""
    
    @IBOutlet weak var laCustomerNameAr: UILabel!
    let Child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child_1")as! Child_CustomerInformation
    
    @IBOutlet weak var laCustomerNameEn: UILabel!
    override func viewDidLoad() {
        LoadDisgin()
        ChildType = "1"
       var result =  loadCustomerInfo()
        if result == false{
            return
        }
        super.viewDidLoad()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        
        let Child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child_2")as! Child2_AccontInformationVC
        Child_2.CustomerNum = CustomerNum
        
        let Child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child_3") as!Child3_DeletionInformationVC
        Child_3.CustomerNum = CustomerNum
        
        return [Child_1,Child_2,Child_3]
    }
    func LoadDisgin(){
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = .blue
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 10)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .white
        }
    }
    func loadCustomerInfo( ) ->Bool{
        let soapMessage = String(format :"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getCustomerInfo xmlns='http://37.224.24.195'><C_No>%@</C_No></getCustomerInfo></soap:Body></soap:Envelope>",CustomerNum)
        
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
        }else{
            return false
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
        //var xmldata = NSString(data: mutableData! as Data, encoding: String.Encoding.utf8.rawValue)
        //print("xml is \(xmldata)")
        parser = XMLParser(data : mutableData! as Data )
        parser.delegate = self
        if parser.parse(){
            
        }
        else{
            return
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
        laCustomerNameAr.text = ArrayCustomerInfo[1]
        laCustomerNameEn.text = ArrayCustomerInfo[2]
        Child_1.CustomerNum = CustomerNum
        Child_1.laAccountNumber.text = ArrayCustomerInfo[6]
        var totalVale1 : Double = Double(ArrayCustomerInfo[0])!
        var tranCredit = ""
        if (totalVale1 < 0){
            totalVale1 = totalVale1 * -1
            Child_1.laEndBalance.textColor = .red
            tranCredit = String(format: "%.2f", totalVale1)
            Child_1.laEndBalance.text = "(\(tranCredit))"
        }else{Child_1.laEndBalance.text = ArrayCustomerInfo[0]}
        
        Child_1.lDateCreateAccount.text = ArrayCustomerInfo[7]
        Child_1.laStartBalance.text = ArrayCustomerInfo[13]
        if (ArrayCustomerInfo[14] == "1")
        {
            Child_1.laTransType.text = "مدين"
        }else if (ArrayCustomerInfo[14] == "2"){
            Child_1.laTransType.text = "دائن"
        }
        else {
            Child_1.laTransType.text = "مدين ودائن "
        }
        AccMaxOk = ArrayCustomerInfo[15]
        AccCusMax = ArrayCustomerInfo[16]
        AccChekMax = ArrayCustomerInfo[17]
        
    }
    
    }
    

