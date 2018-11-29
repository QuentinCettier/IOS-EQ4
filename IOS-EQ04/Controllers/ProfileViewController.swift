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
import MapKit


class ProfileViewController: UIViewController, UITabBarDelegate{
    
    @IBOutlet weak var addDrinkItem: UITabBarItem!
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var profileBarItem: UITabBarItem!
    @IBOutlet weak var partyBarItem: UITabBarItem!
    @IBOutlet weak var feedBarItem: UITabBarItem!
    
    @IBOutlet weak var adressProfile: UILabel!
    @IBOutlet weak var heightProfile: UILabel!
    @IBOutlet weak var weightProfile: UILabel!
    @IBOutlet weak var ageProfile: UILabel!
    @IBOutlet weak var firstNameProfile: UILabel!
    @IBOutlet weak var notificationProfile: UILabel!
    
    
    @IBOutlet weak var localProfile: UILabel!
    
    @IBOutlet weak var consumptionDescription: UILabel!
    @IBOutlet weak var localDescription: UILabel!
    @IBAction func ProfileAction(_ sender: Any) {
        self.performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameProfile.font = localProfile.font.withSize(28)
        localProfile.font = localProfile.font.withSize(20)
        localDescription.font = localDescription.font.withSize(14)
        notificationProfile.font = notificationProfile.font.withSize(20)
        consumptionDescription.font = consumptionDescription.font.withSize(14)
        
        tabBar.delegate = self
        
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()) ")
                    if let lastName = document.data()["lastName"] as? String{
                        if let firstName = Auth.auth().currentUser?.displayName{
                            self.firstNameProfile.text =  lastName
                        }
                    }
                    if let height = document.data()["height"] as? String{
                        self.heightProfile.text = height
                    }
                    if let weight = document.data()["weight"] as? String{
                        self.weightProfile.text = weight
                    }
                    if let age = document.data()["age"] as? String{
                        self.ageProfile.text = age
                    }
                    if let home = document.data()["adress"] as? String{
                        self.adressProfile.text = home
                    }
                }
            }
        }
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
            let PartyViewController = myStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
            self.present(PartyViewController, animated: false, completion: nil)
            
        }
    }
    
    
}
