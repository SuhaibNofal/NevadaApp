//
//  mapViewController.swift
//  Aldyabe
//
//  Created by nofal on 15/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import GoogleMaps
class mapViewController: UIViewController {
var mapview : GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 43, longitude: -77, zoom: 15)
        mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
