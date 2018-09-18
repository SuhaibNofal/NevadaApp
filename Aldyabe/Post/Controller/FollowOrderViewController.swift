//
//  FollowOrderViewController.swift
//  Aldyabe
//
//  Created by nofal on 15/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
import GoogleMaps
class FollowOrderViewController: UIViewController,GMSMapViewDelegate {
    
    var mapview : GMSMapView!
    @IBOutlet weak var buCallDriver: UIButton!
    @IBOutlet weak var buCallCompany: UIButton!
    @IBOutlet weak var buUpdate: UIButton!
    @IBOutlet weak var tableFollowOrder: UITableView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var laDriverName: UILabel!
    @IBOutlet weak var laOrderDate: UILabel!
    @IBOutlet weak var laOrderNo: UILabel!
    var latitude = 44
    var longtude = -77
    
    
    override func viewDidLoad() {
        
        
        let imgaeBack = ImageGradint(imageback: imgBackGround)
        //imgaeBack.backimage()
         buStyleRadius()
        let camera1 = GMSCameraPosition.camera(withLatitude: 44, longitude: -77, zoom: 5)
        mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera1)
        
        mapview.delegate = self
        
        let marrker = GMSMarker()
        marrker.position = CLLocationCoordinate2D(latitude: 44,longitude: -77)
        marrker.snippet = "sdsddssdsd"
        marrker.title = "suhaub"
        marrker.map = self.mapview
        self.viewMap = mapview
        
        super.viewDidLoad()
       
        
       

    }
    
    
    func buStyleRadius()
    {
        buCallDriver.layer.cornerRadius = 5
        buCallCompany.layer.cornerRadius = 5
        buUpdate.layer.cornerRadius = 5
    }
    

    @IBAction func buOpenMap(_ sender: Any) {
        let customURL = "comgooglemaps://"
        
        if UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/@31.979339,35.849406,15z")!){
            UIApplication.shared.openURL(NSURL(string: customURL) as! URL)
        
        } else
        {
            NSLog("Can't use com.google.maps://");
        }
    
    }

}

