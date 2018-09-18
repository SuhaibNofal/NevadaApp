//
//  TableRatingReportCellTableViewCell.swift
//  Aldyabe
//
//  Created by nofal on 16/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
protocol RatingCellDelegate : class {
    func didPressButton(_ tag: Int)
}

class TableRatingReportCell: UITableViewCell {
     weak var cellDelegate: RatingCellDelegate?
    @IBOutlet weak var NumOfOrder: UILabel!
    @IBOutlet weak var NameCustomer: UILabel!
    @IBOutlet weak var Rating: UILabel!
    @IBOutlet weak var information : UIButton!

    @IBAction func buttonPressed(_ sender: Any) {
        cellDelegate?.didPressButton((sender as AnyObject).tag)

    }
}
