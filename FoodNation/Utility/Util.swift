//
//  Util.swift
//  FoodNation
//
//  Created by Aakash Sinha on 24/07/21.
//

import UIKit

var activityView: UIView?

extension UIViewController {
    func showSpinner() {
         activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .large)
        ai.center = activityView!.center
        ai.startAnimating()
        activityView?.addSubview(ai)
        self.view.addSubview(activityView!)
    }
    
    func removeSpinner() {
        activityView?.removeFromSuperview()
       // activityView?.nil
    }
}
