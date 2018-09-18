//
//  Child3_DeletionInformationVC.swift
//  Aldyabe
//
//  Created by nofal on 10/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Child3_DeletionInformationVC: UIViewController {
@IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var laCountryData: UILabel!
    @IBOutlet weak var laCityData: UILabel!
    @IBOutlet weak var laPhoneData: UILabel!
    @IBOutlet weak var laOfficeData: UILabel!
    @IBOutlet weak var laAddressData: UILabel!
    @IBOutlet weak var laEmailData: UILabel!
    override func viewDidLoad() {
        ImageGradint(imageback: imageBack).backimage1()
        
        super.viewDidLoad()

    }

}
extension Child3_DeletionInformationVC : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "معلومات العميل")
    }
}
