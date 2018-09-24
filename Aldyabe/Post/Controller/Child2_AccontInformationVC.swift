//
//  Child2_AccontInformationVC.swift
//  Aldyabe
//
//  Created by nofal on 10/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class Child2_AccontInformationVC: UIViewController ,XMLParserDelegate,NSURLConnectionDataDelegate,UITextFieldDelegate{
    var CustomerNum :String = ""
    var mutableData :NSMutableData?
    var parser1 = XMLParser()
    var parser2 = XMLParser()
    var connection1 :NSURLConnection?
    var connection2 :NSURLConnection?
    var ArrayCustomerInfo = [String]()
    var captureData = ""
    var suhaib = ""
    var accCustMax = ""
    var accChkMax = ""
    var isMaxOk  = "False"
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var txAccCustMax: UITextField!
    @IBOutlet weak var txAccChkMax: UITextField!
    @IBOutlet weak var buCheckBox: UIButton!
    let button = UIButton(type: UIButtonType.custom)
    override func viewDidLoad() {
        
        var x: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector (tap))
        self.view.addGestureRecognizer(x)
        
        var result = loadCustomerInfo1()
        ImageGradint(imageback: imageBack).backimage1()
        print(result)
        if result == false{return}
        super.viewDidLoad()
        
    }
    @objc func tap (sss:UITapGestureRecognizer){
        self.view .endEditing(true)
    }
    
    

    @IBAction func buCheckBox(_ sender: Any) {
        if isMaxOk == "False"{
            buCheckBox.setBackgroundImage(UIImage(named:"abc_btn_check_to_on_mtrl_015"), for: UIControlState.normal)
            
            isMaxOk = "True"
        }else{
            buCheckBox.setBackgroundImage(UIImage(named:"abc_btn_check_to_on_mtrl_000"), for: .normal)
            
            isMaxOk = "False"
        }
    }
    func updateCustomerInfo() ->Bool{
        if txAccChkMax.text == "" {
            accChkMax = "0"
        }
        if txAccCustMax.text == ""{
            accCustMax = "0"
        }
        let soapMessage = String(format :"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><updateCustomerInfo xmlns='http://37.224.24.195'><C_No>%@</C_No><C_Max>%@</C_Max><C_ChkMax>%@</C_ChkMax><C_CanMax>%@</C_CanMax></updateCustomerInfo></soap:Body></soap:Envelope>",CustomerNum,accCustMax,accChkMax,isMaxOk)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=updateCustomerInfo"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        connection2 = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        connection2?.start()
        if connection2 != nil{
            return true
        }else{
            return false
        }
        
    }
    
    func loadCustomerInfo1() ->Bool{
        let soapMessage = String(format :"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getCustomerInfo xmlns='http://37.224.24.195'><C_No>%@</C_No></getCustomerInfo></soap:Body></soap:Envelope>",CustomerNum)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getCustomerInfo"
        let url = URL(string: urlString)
        let theRequest = NSMutableURLRequest(url: url!)
        let msgLength = soapMessage.characters.count
        theRequest.addValue("text/xml", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLength), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = soapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        
        connection1 = NSURLConnection(request: theRequest as URLRequest, delegate: self)
        connection1?.start()
        if connection1 != nil{
            return true
        }else{
            return false
            
        }
        
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error)
    {
        print(error)
        print("no connection")
        if connection == connection2{Child2_AccontInformationVC.popUp(context: self, msg: "لم يتم نحديث المعلومات")}
        return
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
       if connection == connection1{
        parser1 = XMLParser(data : mutableData! as Data )
        parser1.delegate = self
        if parser1.parse(){
            
        }
        }
        else {
        parser2 = XMLParser(data : mutableData! as Data )
        parser2.delegate = self
        if parser2.parse(){
            
        }
        }
        
    }
    
    
    
    
    
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        
    }
    
    
    internal func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict:[String : String] = [:])
    {
        if parser == parser{
        suhaib = ""
        
        captureData = elementName
        }
       
        
    }
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {  if parser == parser1{
        if captureData == "string"
        {
            suhaib+=string
        }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {     if parser == parser1{
        if elementName == "string"{
            ArrayCustomerInfo.append(suhaib)
            
        }
        }
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {if ArrayCustomerInfo.count > 0{
        if parser == parser1{
           txAccCustMax.text = ArrayCustomerInfo[16]
            txAccChkMax.text = ArrayCustomerInfo[17]
            isMaxOk = ArrayCustomerInfo[15]
            print(isMaxOk)
            if isMaxOk == "False" {
            buCheckBox.setBackgroundImage(UIImage(named:"abc_btn_check_to_on_mtrl_000"), for: .normal)
                
                //isMaxOk = "True"
            }else {
                buCheckBox.setBackgroundImage(UIImage(named:"abc_btn_check_to_on_mtrl_015"), for: .normal)
                

                //isMaxOk = "False"
            }
            
        }else{
            Child2_AccontInformationVC.popUp(context: self, msg: "تم نحديث المعلومات")
        }
        }
    }

    @IBAction func UpdateCustomer(_ sender: Any) {
        accCustMax = txAccCustMax.text!
        accChkMax = txAccChkMax.text!
        updateCustomerInfo()
        
    }
    static func popUp(context ctx: UIViewController, msg: String) {
        let c = ctx.view.frame.size.height / 2
        let toast = UILabel(frame:
            CGRect(x: (ctx.view.frame.size.width / 2) - 50, y: ctx.view.frame.size.height / 2 + (c / 2) + 10,
                   width: 100, height: 30))
        
        toast.backgroundColor = UIColor.lightGray
        toast.textColor = UIColor.white
        toast.textAlignment = .center;
        toast.numberOfLines = 3
        toast.font = UIFont.systemFont(ofSize: 10)
        toast.layer.cornerRadius = 12;
        toast.clipsToBounds  =  true
        
        toast.text = msg
        
        ctx.view.addSubview(toast)
        
        UIView.animate(withDuration: 5.0, delay: 0.2,
                       options: .curveEaseOut, animations: {
                        toast.alpha = 0.0
        }, completion: {(isCompleted) in
            toast.removeFromSuperview()
        })
    }
}
extension Child2_AccontInformationVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "معلومات الذمة")
    }
    
}
