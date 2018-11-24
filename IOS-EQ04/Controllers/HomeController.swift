//
//  HomeController.swift
//  IOS-EQ04
//
//  Created by Quentin on 10/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class HomeController: UIViewController, UITabBarDelegate{

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var addDrinkItem: UITabBarItem!
    
    
    
    let LogoutButton: UIButton = {
        var btn = UIButton()
        
        btn.frame = (CGRect(x: 0, y: 0, width: 100, height: 0))
        btn.setTitle("Logout", for: .normal)
        btn.titleLabel?.font = UIFont(name: "SF-Pro-Text-Medium", size: 19.0)
        btn.backgroundColor = UIColor(hex: "F89934")
        btn.layer.cornerRadius = 15
        
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.shadowRadius = 2
        btn.layer.shadowOpacity = 0.2
        
        btn.addTarget(self, action: #selector(handleLogoutAction), for: .touchUpInside)
        
        return btn
    }()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBar.delegate = self
       
        
        view.addSubview(LogoutButton)
        setupLogoutButton()
        
        // Do any additional setup after loading the view
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == addDrinkItem {
            let myStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let AddDrinkController = myStoryboard.instantiateViewController(withIdentifier: "AddDrinkController")
            self.present(AddDrinkController, animated: false, completion: nil)
        }
    }
    
    @objc func handleLogoutAction(sender: UIButton!) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
    private func setupLogoutButton() {
        LogoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        LogoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LogoutButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -15).isActive = true
        LogoutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        LogoutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        LogoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

    }

}
