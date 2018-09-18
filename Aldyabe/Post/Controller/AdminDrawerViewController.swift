//
//  DrawerVCViewController.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class AdminDrawerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var drawer = Array<AdminDrawer>()
    
    
    @IBOutlet weak var draweTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        drawer.append(AdminDrawer(Name: "ارسال رسالة لجميع العملاء",img: "im_contact_us"))
        drawer.append(AdminDrawer(Name: "تقرير التقيمات",img: "im_rating"))
        drawer.append(AdminDrawer(Name: " تقرير الردود اليومية",img: "im_daily"))
        self.draweTable.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AdminDrawerCell = tableView.dequeueReusableCell(withIdentifier: "AdminDrawerCell", for: indexPath) as! AdminDrawerCell
        cell.laName.text = drawer[indexPath.row].Name
        cell.imgLa.image = UIImage(named: drawer[indexPath.row].img!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "DailyTransaction") as! DailyTransactionViewController
            
            self.present(controller, animated: true, completion: nil)
            
        }
        else if(indexPath.row == 1)
        {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "RatingReport") as! RatingReportViewController
            
            self.present(controller, animated: true, completion: nil)
            
        }
       
        
    }

}
