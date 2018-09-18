//
//  PopNotesRatingVC.swift
//  Aldyabe
//
//  Created by nofal on 03/09/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit

class PopNotesRatingVC: UIViewController {
    var Notes : String?
    var dilay : String?
    var Qantitiy : String?
    var Matereal : String?
    @IBOutlet weak var laMaterial: UILabel!
    @IBOutlet weak var laQantity: UILabel!
    @IBOutlet weak var ladilay: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    @IBOutlet weak var PopupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
     txtNotes.text = Notes
    if dilay == "True"{ladilay.text = "نعم"}else{ladilay.text = "لا"}
    if Qantitiy == "True"{laQantity.text = "نعم"}else{laQantity.text = "لا"}
    if Matereal == "True"{laMaterial.text = "نعم"}else{laMaterial.text = "لا"}
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != PopupView {
            dismiss(animated: true, completion: nil)
        }
    }

    
    

    

}
