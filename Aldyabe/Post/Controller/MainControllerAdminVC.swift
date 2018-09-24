//
//  ViewController.swift
//  Aldyabe
//
//  Created by nofal on 13/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class MainControllerAdminVC: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate ,NSURLConnectionDataDelegate{
    var parser = XMLParser()
    var array  = Array<String>()
    
    @IBOutlet weak var buSubAccount: UIButton!
    @IBOutlet weak var buLastTrans: UIButton!
    @IBOutlet weak var buSendSms: UIButton!
    @IBOutlet weak var buCustomerInfo: UIButton!
    var captureData :String = ""
    var CustomerData = Array<arrayAdmin>()
    var mutableData: NSMutableData?
    var suhaib : String = ""
    var arrayAdmin1 = [arrayAdmin]()
    var x:String?
    var y:String?
    var z : String?
    @IBOutlet weak var MainTable: UITableView!
    
    
    
    
    override func viewDidLoad() {
       
        loadDataToMainAdmin()
        buSendSms.isEnabled = false
        buLastTrans.isEnabled = false
        buSubAccount.isEnabled = false
        buCustomerInfo.isEnabled = false
        
        super.viewDidLoad()
    }
    
    
    func loadDataToMainAdmin() ->Bool{
        let soapMessage = "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getAllCustomer xmlns='http://37.224.24.195' /></soap:Body></soap:Envelope>"
    
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
        MainTable.reloadData()
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
    arrayAdmin1.append(arrayAdmin(nu: nu,Name: Name,account: account))
    }
   
}
func parserDidEndDocument(_ parser: XMLParser)
{
   
}
   

    
    
    
    @IBAction func menuButtonPresed(_ sender: Any) {
        let appdel = UIApplication.shared.delegate as! AppDelegate
        appdel.drawercontroler.setDrawerState(.opened, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MainAdminCell = MainTable.dequeueReusableCell(withIdentifier: "MainCellAdmin", for: indexPath) as! MainAdminCell
        cell.laCustomName.text = arrayAdmin1[indexPath.row].Name
        cell.laCustmNu.text = arrayAdmin1[indexPath.row].Nu
        cell.laCustomAccou.text = arrayAdmin1[indexPath.row].account
        cell.backgroundColor = UIColor(red:0.91, green:1.00, blue:0.90, alpha:1.0)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAdmin1.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     y = arrayAdmin1[indexPath.row].Name
        x = arrayAdmin1[indexPath.row].account
       z = arrayAdmin1[indexPath.row].Nu
        //print(x,y,z)
        buSendSms.isEnabled = true
        buLastTrans.isEnabled = true
        buSubAccount.isEnabled = true
        buCustomerInfo.isEnabled = true
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "lastTrans"){
            let vc = segue.destination as! LastTransActionViewController
            vc.name = y
            vc.number = x
            print(vc.name)
        }else if(segue.identifier == "SendMessageCu"){
            let vc = segue.destination as! SendSmsViewController
            vc.accNumber = x
            vc.customerName = y
            
        }else if(segue.identifier == "GoToSubAccount"){
            let vc = segue.destination as! AccountSubActivityVC
            vc.accNumber = x!
            vc.name = y!
        }else if (segue.identifier == "CustomerInfo"){
            let vc = segue.destination as! ContainerViewController
            vc.CustomerNum = z!
            
            
            
        }
        
    }
    
}
 


