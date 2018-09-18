//
//  Child2_AccontInformationVC.swift
//  Aldyabe
//
//  Created by nofal on 10/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class Child2_AccontInformationVC: UIViewController {
    @IBOutlet weak var imageBack: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
       ImageGradint(imageback: imageBack).backimage1()
        
    }

   

}
extension Child2_AccontInformationVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "معلومات الذمة")
    }
    
}
