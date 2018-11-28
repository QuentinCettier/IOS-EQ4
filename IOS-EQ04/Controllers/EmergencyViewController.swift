//
//  EmergencyViewController.swift
//  IOS-EQ04
//
//  Created by Ryzlane Arsac-Gothière on 28/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class EmergencyViewController: UIViewController {
    @IBOutlet weak var callButton: UIButton!
    
    @IBAction func call(_ sender: Any) {
        if let url = URL(string: "tel://\(112)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
                
            } else {
                UIApplication.shared.openURL(url)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callButton.layer.cornerRadius = 15
    }
    
}
