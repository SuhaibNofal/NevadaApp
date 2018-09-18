//
//  SendSmsViewController.swift
//  Aldyabe
//
//  Created by nofal on 30/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class SendSmsViewController: UIViewController,XMLParserDelegate,NSURLConnectionDataDelegate {
    var accNumber :String?
    var txt :String = ""
    var customerName : String?
    var parser = XMLParser()
    var mutableData :NSMutableData?
    var captureElemantName = ""
    var capturedata = ""
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var txtView: UIView!
    @IBOutlet weak var laCustomerName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      laCustomerName.text = customerName!
        print(accNumber)
        
    }
    func sendMessages(){
        txt = txtMessage.text
        let soapMessage = String(format: "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><SendSMS xmlns='http://37.224.24.195'><VarAccNo>%@</VarAccNo><VarMessage>%@</VarMessage></SendSMS></soap:Body></soap:Envelope>",accNumber!,txt)
      
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=SendSMS"
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
        print(error)
    }
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        mutableData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        mutableData?.append(data)
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        parser = XMLParser(data: mutableData! as Data)
        parser.delegate = self
        if parser.parse(){
            print("suhaib")
        }
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        captureElemantName = elementName
        capturedata  = ""
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if captureElemantName == "string"{
            capturedata+=string
            //print(string)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if captureElemantName == "string"{
            print(capturedata)
            
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        
    }
    @IBAction func buSendMessage(_ sender: Any) {
        
        if txtMessage.text != ""{
            sendMessages()
        }else{
            txtView.backgroundColor = UIColor(red:0.55, green:0.00, blue:0.00, alpha:1.0)
            let alert = UIAlertController(title: "تنبيه", message: "الرجاء ادخال الرسالة", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    }


