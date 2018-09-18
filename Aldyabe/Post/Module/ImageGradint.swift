//
//  ImageGradintViewController.swift
//  Aldyabe
//
//  Created by nofal on 14/08/2018.
//  Copyright © 2018 Nofal. All rights reserved.
//

import UIKit
class ImageGradint {
   
    var imageback: UIImageView!
    init(imageback : UIImageView) {
        self.imageback = imageback
        //backimage(image: imageback)
    }
    func backimage()
    {
        let gradient = CAGradientLayer()
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        gradient.frame = defaultNavigationBarFrame
        
        //colors
        let gradientDark = UIColor(red: 0.09, green:0.29, blue: 0.50, alpha: 1.0)
        let gradientLight = UIColor(red: 0.92, green:0.96, blue: 1.00, alpha: 1.0)
        let gradientLight1 = UIColor(red: 0.02, green:0.05, blue: 0.10, alpha: 1.0)
        
        gradient.colors = [gradientDark.cgColor,gradientLight.cgColor,gradientLight1.cgColor]
        // Create image.
        let imageBG: UIImage = self.gradientImage(fromLayer: gradient)
        
        imageback.image = imageBG
    }
    func gradientImage(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
    func backimage1()
    {
        let gradient = CAGradientLayer()
        let screenHeight = UIScreen.main.bounds.size.height
        let screenWidth = UIScreen.main.bounds.size.width
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        gradient.frame = defaultNavigationBarFrame
        
        //colors
        let gradientDark = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        let gradientLight = UIColor(red: 0.92, green:0.96, blue: 1.00, alpha: 1.0)
        let gradientLight1 = UIColor(red:0.60, green:0.71, blue:0.93, alpha:1.0)
        
        gradient.colors = [gradientDark.cgColor,gradientLight.cgColor,gradientLight1.cgColor]
        // Create image.
        let imageBG: UIImage = self.gradientImage(fromLayer: gradient)
        
        imageback.image = imageBG
    }
    
}
