//
//  LogINVC.swift
//  Aldyabe
//
//  Created by nofal on 13/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class LogINVC: UIViewController,XMLParserDelegate ,NSURLConnectionDataDelegate{
    

    @IBOutlet weak var laRed: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var buLogin: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var imgPass: UIImageView!
    @IBOutlet weak var txtPass: UITextField!
    let textBorder = UIColor.blue
    let textBorder1 = UIColor.red
    let buttonbackground = UIColor.gray
    var mutableData: NSMutableData?
    var parser = XMLParser()
    
    var captureData:String = ""
    var isAdmin  = "0"
    var flag : Bool?
    var accName = ""
    var accNo = ""
    var accCity = ""
    var accDate = ""
    var accStartBalance = ""
    var accEndBalance = ""
    var AccName = ""
    var AccNo = ""
    var AccCity = ""
    var AccDate = ""
    var AccStartBalance = ""
    var AccEndBalance = ""
     var array  = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         addborder()
        
        
        
     
    }
   
    func LoadData() ->Bool {
        let User = txtUser.text
        let Name = txtPass.text
        if ((User?.isEmpty)! && (Name?.isEmpty)!){
            txtUser.layer.borderColor = UIColor.red.cgColor
            imgUser.layer.borderColor = UIColor.red.cgColor
             print("plese insert User and password")
            return false
           
        }
        let soapMessage = String(format: "<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><login xmlns='http://37.224.24.195'><User>%@</User><Name>%@</Name></login></soap:Body></soap:Envelope>", User!, Name!)
        
        
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=login"
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
        
            parser.parse()
        }
       
    
    func parserDidStartDocument(_ parser: XMLParser)
    {
        flag = false
    }
    
    
    private func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict:[String : Any] = [:])
    {
    captureData = elementName
    }
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
       
        array.append(string)
            print(string)
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        
    }
    func parserDidEndDocument(_ parser: XMLParser)
    {    if array.count > 0{
        print("array have item")
        if array[0] == "Driver"
        {
            accName = array[3]
            accNo = array[2]
            accCity = array[4]
            accStartBalance = array[1]
            let story :UIStoryboard = UIStoryboard(name : "Driver",bundle : nil)
            let maincustomer = story.instantiateViewController(withIdentifier: "MainDriverViewController") as! MainDriverViewController
            maincustomer.ara = self.array
            let appdel=UIApplication.shared.delegate as! AppDelegate
            let mainVC = story.instantiateViewController(withIdentifier: "MainDriverViewController")
            let menuVC = story.instantiateViewController(withIdentifier: "DrawerDriver")
            appdel.drawercontroler.mainViewController = mainVC
            appdel.drawercontroler.drawerViewController = menuVC
            appdel.window?.rootViewController = appdel.drawercontroler
            appdel.window?.makeKeyAndVisible()
            self.present(maincustomer, animated: true, completion: nil)
            print(accName,"+",accNo,"+",accCity,"+",accStartBalance)
        }
        else if array[0] == "Admin"{
            isAdmin = "1"
            drawer()
        }else {
            AccName = array[1]
            AccNo = array[0]
            AccCity = array[2]
            AccDate = array[3]
            AccStartBalance = array[4]
            AccEndBalance = array[5]
            print(AccName,"+",AccNo,"+",AccCity,"+",AccDate,"+",AccStartBalance,"+",AccEndBalance )
            
            let story :UIStoryboard = UIStoryboard(name : "Customer",bundle : nil)
            let maincustomer = story.instantiateViewController(withIdentifier: "MainCustomerViewController") as! MainCustomerViewController
            maincustomer.ara = self.array
            self.present(maincustomer, animated: true, completion: nil)
        }
        
    }else{
        print("noDataFound")
        laRed.isHidden = false
        }
        
    }
    
    
    
    
    
    
    func redFaile()
    {
        if let file = Bundle.main.path(forResource: "suhaib",ofType:"xml") {
            let url = NSURL.init(fileURLWithPath: file)
            if let parser = XMLParser(contentsOf: url as URL ){
                parser.delegate = self
                if parser.parse(){
                    
                }else{
                    print("can't")
                }
                
            }else{
                print("can't")
            }
        }
    }
    func addborder(){
        txtUser.layer.borderWidth = 1.0
        txtUser.layer.borderColor = textBorder.cgColor
        txtPass.layer.borderWidth = 1.0
        txtPass.layer.borderColor = textBorder.cgColor
        buLogin.layer.backgroundColor = buttonbackground.cgColor
        imgUser.layer.borderWidth = 1.0
        imgUser.layer.borderColor = textBorder.cgColor
        imgPass.layer.borderWidth = 1.0
        imgPass.layer.borderColor = textBorder.cgColor
    }
    
    func drawerDriver()
    {
        let appdel=UIApplication.shared.delegate as! AppDelegate
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainDriverViewController")
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "DrawerDriver")
        let story :UIStoryboard = UIStoryboard(name : "Driver",bundle : nil)
        
        appdel.drawercontroler.mainViewController = mainVC
        appdel.drawercontroler.drawerViewController = menuVC
        appdel.window?.rootViewController = appdel.drawercontroler
        appdel.window?.makeKeyAndVisible()
    }
    func drawer()
    {
        let appdel=UIApplication.shared.delegate as! AppDelegate
        let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenAdmin")
        
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "Drawer")
        appdel.drawercontroler.mainViewController = mainVC
        appdel.drawercontroler.drawerViewController = menuVC
        appdel.window?.rootViewController = appdel.drawercontroler
        appdel.window?.makeKeyAndVisible()
    }
    @IBAction func Login(_ sender: Any) {
 LoadData()
}
}

