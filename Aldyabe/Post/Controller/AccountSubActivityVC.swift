//
//  AccountSubActivityVC.swift
//  Aldyabe
//
//  Created by nofal on 03/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class AccountSubActivityVC: UIViewController,XMLParserDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate {
    var isAdmin = ""
    @IBOutlet weak var tableItemselected: UITableView!
    var mutableData : NSMutableData?
    var array = [SubAccount]()
    var arraytrnsType = [String]()
    var arrayTransTypeDetails = [SubAccount]()
    var captureElemantName = ""
    var captureString = ""
    var parser = XMLParser()
    var FromDept:Int = 0
    var ToDept : Int = 0
    var Fromcredit : Int = 0
    var ToCredit : Int = 0
    var From  :Int = 0
    var To : Int = 150
    var DataFrom : String = "01-05-2016"
    var DateTo : String = ""
    var noty = 5
    var noty2 = 6
    var accNumber = ""
    var name = ""
    var date = Date()
    var busearshclick : Bool = false
    var transType = ""
    var itemSelectedinTableView :String = ""
    @IBOutlet weak var tableSubAccount: UITableView!
    @IBOutlet weak var laCustomerName: UILabel!
    @IBOutlet weak var laNoTransaction: UILabel!
    @IBOutlet weak var laAccNumber: UILabel!
    @IBOutlet weak var txtFromDept: UITextField!
    @IBOutlet weak var txtToDept: UITextField!
    @IBOutlet weak var txtFromCredit: UITextField!
    var transRange = 0
    @IBOutlet weak var txtToCredit: UITextField!
    
    
    @IBOutlet var buGetTrans: [UIButton]!
    @IBOutlet weak var buTranType: UIButton!
    @IBOutlet weak var buDateFrom: UIButton!
    @IBOutlet weak var buDateTo: UIButton!
    @IBOutlet weak var laSumtranCredit: UILabel!
    @IBOutlet weak var laSumTranDebt: UILabel!
    @IBOutlet weak var laTotalBal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         selectcurrentdate()
        laAccNumber.text = accNumber
        laCustomerName.text = name
        callData()
        itemSelectedinTableView = (buTranType.titleLabel?.text)!
        NotificationCenter.default.addObserver(self,selector: #selector(handlPopupDateclosing), name: NSNotification.Name(rawValue: "suhaib2"), object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(handlPopupDateclosing), name: NSNotification.Name(rawValue: "suhaib3"), object: nil)
        
    }
    @objc func handlPopupDateclosing(notification:Notification){
        if notification.name.rawValue == "suhaib2"{
            let date = notification.object as! DatePopupViewController
            buDateFrom.setTitle(date.formattedData, for: .normal)
            DataFrom = date.formattedData
        }else if notification.name.rawValue == "suhaib3"{
            let date = notification.object as! DatePopupViewController
            buDateTo.setTitle(date.formattedData, for: .normal)
            DateTo = date.formattedData
        }
        }
    //convert value of textView from Arabic to English
    func converFromArabic (txtConvert :String) ->Int {
        let numberStr: String = txtConvert
        let formatter: NumberFormatter = NumberFormatter()
        formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let final = formatter.number(from: numberStr)
        let IntNumber = Int(truncating: final!)
        //print("\(IntNumber)")
        return IntNumber
        
    }
    //set current date when open view controller to button title
    func selectcurrentdate()
    {
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy"
        formater.locale = Locale(identifier: "en")
        let myStringafd = formater.string(from: Date())
        buDateTo.setTitle(myStringafd, for: .normal)
        buDateFrom.setTitle("02-05-2016", for: .normal)
        DateTo = myStringafd
    }
    // call web service
    @IBAction func buSearch(_ sender: Any) {
        busearshclick = true
        if txtFromDept.text == ""{
            FromDept = 0
        }else{
        FromDept = converFromArabic(txtConvert: txtFromDept.text!)
        }
        if txtToDept.text == ""{
            ToDept = 0
        }else{
         ToDept = converFromArabic(txtConvert: txtToDept.text!)
        }
        if txtFromCredit.text == ""{
           Fromcredit = 0
        }else{
            Fromcredit = converFromArabic(txtConvert: txtFromCredit.text!)
        }
        if txtToCredit.text == ""{
            ToCredit = 0
        }else{
            ToCredit = converFromArabic(txtConvert: txtToCredit.text!)
        }
        callData()

    }
    func reloadTable(){
        if !(itemSelectedinTableView == arraytrnsType[0] ){
        var items = [SubAccount]()
        
        items = array.filter{($0.MotionType == itemSelectedinTableView )
        }
            array = items
        }
        if array.isEmpty {
            laNoTransaction.isHidden = false
            tableSubAccount.isHidden = true
            
        }
        tableSubAccount.reloadData()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateFromAccSub"{
            let vc = segue.destination as! DatePopupViewController
            vc.not = noty
        }else if segue.identifier == "dateToAccSub"{
            let vc = segue.destination as! DatePopupViewController
            vc.not = noty2
        }
    }
    
    @IBAction func buAllTrans(_ sender: Any) {
        tableItemselected.isHidden = !tableItemselected.isHidden
        
    }
    
   
    
    @IBAction func GetTrns(_ sender: UIButton) {
        if sender.tag == 0 {
            From = 0
            To = 0
            callData()
        }else if sender.tag == 1 {
            From = From - 150
            To = From - 150
            callData()
        }else if sender.tag == 2 {
            From = 0
            To = 150
            callData()
        }else if sender.tag == 3 {
            From = From + 150
            To = From + 150
            callData()
        }
        else {
            From = 0
            To = 1
            callData()
        }
    }

    func callData()  {
        buGetTrans [3].isEnabled = true
        buGetTrans [4].isEnabled = true
        laNoTransaction.isHidden = true
        tableSubAccount.isHidden = false
        transRange = 0
        let soapMessage = String(format:"<?xml version='1.0' encoding='utf-8'?><soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'><soap:Body><getSubsidary xmlns='http://37.224.24.195'><AcctNo>%@</AcctNo><from>\(From)</from><to>\(To)</to><dateFrom>%@</dateFrom><dateTo>%@</dateTo><fromDE>\(FromDept)</fromDE><toDE>\(ToDept)</toDE><fromCr>\(Fromcredit)</fromCr><toCr>\(ToCredit)</toCr></getSubsidary></soap:Body></soap:Envelope>",accNumber,DataFrom,DateTo)
        
        let urlString = "http://37.224.24.195/AndroidWS/GetInfo.asmx?op=getSubsidary"
        let url = URL(string: urlString)
        let theRequst = NSMutableURLRequest(url:url!)
        let messageLength = soapMessage.characters.count
        theRequst.addValue("text/xml",forHTTPHeaderField: "Content-Type")
        theRequst.addValue(String(messageLength), forHTTPHeaderField: "Content-Length")
        theRequst.httpMethod = "POST"
        theRequst.httpBody = soapMessage.data(using: String.Encoding.utf8,allowLossyConversion: false)
        if NSURLConnection(request: theRequst as URLRequest, delegate: self) != nil{
            print("hi")
        }else{print("hhh")}
       
        
    }
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        print(error)
    }
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        mutableData = NSMutableData()
    }
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        array.removeAll()
        mutableData?.append(data)
        
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        parser = XMLParser(data: mutableData! as Data)
        parser.delegate = self
        if parser.parse(){
            tableSubAccount.reloadData()
            tableItemselected.reloadData()
            print("statr parser")
        }else{
            print("can't start parser")
        }
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        arraytrnsType.append("جميع الحوالات")
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        captureString = ""
        captureElemantName = elementName
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        captureString+=string
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        var exit = false
        if elementName == "string"{
         let arr = captureString.components(separatedBy: "&")
        if arr.count > 10 {
        for x in 0..<arraytrnsType.count {
                if arraytrnsType[x] == arr[0]
                {
                    exit = true
                }
            }
            if (!exit){
                arraytrnsType.append(arr[0])
            }
        
        var MotionType = arr[0]
        var MotionNum = arr[2]
        var f = Float(arr[4])
        let tranDebt = String(format: "%.2f", f!)
        var ff = Float(arr[6])
        var tranCredit = ""
        if ff == 0{
             tranCredit = String(format: "%.2f", ff!)
        }else{
            let x = String(format: "%.2f", ff!)
            tranCredit = "(\(x))"
        }
        //let tranCredit = String(format: "%.2f", ff!)
        var newString = arr[8]
        newString.removeLast(12)
        let MotionDate = newString.replacingOccurrences(of: "/", with: "-",options:.literal)
        var MotionNumType = arr[10]
        var fDept = Float(arr[12])
        let sumTranDebt = String(format: "%.2f", fDept!)
        //var sumTranCredit = arr[14]
        var fCredit = Float(arr[14])
        var sumTranCredit = ""
        if fCredit == 0{
            sumTranCredit = String(format: "%.2f", fCredit!)
        }else{
            let x = String(format: "%.2f", fCredit!)
            sumTranCredit = "(\(x))"
        }
        //var sumTotalBal = arr[16]
        var fTotalBal = Float(arr[16])
        var ffTotalBal = Double(fTotalBal!)
        var sumTotalBal = ""
        if ffTotalBal < 0{
            ffTotalBal = ffTotalBal * -1
            laTotalBal.textColor = UIColor.red
            sumTotalBal = String(format: "%.2f", ffTotalBal)
        }else{
            let x = String(format: "%.2f", fTotalBal!)
            sumTotalBal = "(\(x))"
        }
      var MotionSumation = arr[18]
            transRange = converFromArabic(txtConvert: MotionSumation)
            
            
        array.append(SubAccount(MotionType: MotionType, MotionNum: MotionNum, tranDebt: tranDebt, tranCredit: tranCredit, MotionDate: MotionDate, MotionNumType: MotionNumType, sumTranDebt: sumTranDebt, sumTranCredit: sumTranCredit, sumTotalBal: sumTotalBal, MotionSumation: MotionSumation))
        laSumtranCredit.text = sumTranCredit
        laSumTranDebt.text = sumTranDebt
        laTotalBal.text = sumTotalBal
        }else{
            
        }
        }
        
    
    }
    func parserDidEndDocument(_ parser: XMLParser) {
       
        if transRange < 10 {
            buGetTrans [3].isEnabled = false
            buGetTrans [4].isEnabled = false
        }
        if array.isEmpty {
            laNoTransaction.isHidden = false
            tableSubAccount.isHidden = true
            
        }
        if busearshclick == true
        {
            reloadTable()
            busearshclick = false
        }
        
    }
    
}
extension AccountSubActivityVC{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableSubAccount{
            
            return array.count
        }else{
            return arraytrnsType.count
        }
        //return arraytypeIntable.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableItemselected{
            let cell :subAccountTypeCell  = tableView.dequeueReusableCell(withIdentifier: "item Select") as! subAccountTypeCell
            cell.label.text = arraytrnsType[indexPath.row]
            return cell
        }
        else {
        let cell : AccountSubCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AccountSubCell") as! AccountSubCellTableViewCell
        cell.laMotionType.text = array[indexPath.row].MotionType
        cell.laMoationDate.text = array[indexPath.row].MotionDate
        cell.laDebt.text = array[indexPath.row].tranDebt
        cell.laCredit.text = array[indexPath.row].tranCredit
            return cell
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableItemselected
        {
            itemSelectedinTableView = arraytrnsType[indexPath.row]
            buTranType.setTitle(itemSelectedinTableView, for: .normal)
            tableItemselected.isHidden = true
        }
        else if tableView == tableSubAccount {
            let story :UIStoryboard = UIStoryboard(name : "Main",bundle : nil)
            let vc = story.instantiateViewController(withIdentifier: "LastTransAction") as! LastTransActionViewController
            vc.number = "---"
            vc.name = "---"
            vc.isAdmin = "2"
            vc.TranTypeNo = array[indexPath.row].MotionNumType
            vc.TranNo = array[indexPath.row].MotionNum
            //vc.TranNo =
            
             self.present(vc, animated: true, completion: nil)
        }
    }
    
}
