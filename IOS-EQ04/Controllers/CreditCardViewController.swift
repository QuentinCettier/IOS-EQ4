//
//  CreditCardViewController.swift
//  IOS-EQ04
//
//  Created by Quentin on 28/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController, UITabBarDelegate {
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var feedBarItem: UITabBarItem!
    
    @IBOutlet weak var profileBarItem: UITabBarItem!
    @IBOutlet weak var partyBarItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    @IBAction func call(_ sender: Any) {
        if let url = URL(string: "tel://\(0892705705)"), UIApplication.shared.canOpenURL(url) {
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
        
        tabBar.delegate = self
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == feedBarItem {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let HomeViewController = myStoryboard.instantiateViewController(withIdentifier: "HomeController")
            self.present(HomeViewController, animated: false, completion: nil)
            
        } else if item == partyBarItem {
            
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PartyViewController = myStoryboard.instantiateViewController(withIdentifier: "PartyViewController")
            self.present(PartyViewController, animated: false, completion: nil)
            
        } else if item == profileBarItem {
            
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let PartyViewController = myStoryboard.instantiateViewController(withIdentifier: "PartyViewController")
            self.present(PartyViewController, animated: false, completion: nil)
            
        }
    }
}
