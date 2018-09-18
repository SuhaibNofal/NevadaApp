//
//  ImportantLocationViewController.swift
//  Aldyabe
//
//  Created by nofal on 19/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import GoogleMaps
class ImportantLocationViewController: UIViewController,GMSMapViewDelegate {
    @IBOutlet weak var selectPlace:UIButton!
    @IBOutlet weak var DescribePlace:UIButton!
    @IBOutlet weak var showPlace:UIButton!
    @IBOutlet weak var image:UIImageView!
    
    @IBOutlet weak var imgBackGround :UIImageView!
    @IBOutlet weak var viewMap : UIView!
      var mapview : GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buStyleRadius()
        let imgaeBack = ImageGradint(imageback: imgBackGround!)
        //imgaeBack.backimage()
        let camera1 = GMSCameraPosition.camera(withLatitude: 44, longitude: -77, zoom: 5)
        mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera1)
        
        mapview.delegate = self
        
        let marrker = GMSMarker()
        marrker.position = CLLocationCoordinate2D(latitude: 44,longitude: -77)
        marrker.snippet = "sdsddssdsd"
        marrker.title = "suhaub"
        marrker.map = self.mapview
        self.viewMap = mapview
        

        
        
       
      
    }
    func buStyleRadius()
    {
        showPlace.layer.cornerRadius = 5
        
        selectPlace.layer.cornerRadius = 5
        selectPlace.layer.borderWidth = 1
        selectPlace.layer.borderColor = UIColor.black.cgColor
        DescribePlace.layer.cornerRadius = 5
        DescribePlace.layer.borderWidth = 1
        DescribePlace.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

   

}

