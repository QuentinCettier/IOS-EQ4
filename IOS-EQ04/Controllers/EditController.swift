//
//  EditController.swift
//  IOS-EQ04
//
//  Created by Armel Cantin on 26/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class EditController: UIViewController {
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var adressAdd: UITextField!
    @IBOutlet weak var heightAdd: UITextField!
    @IBOutlet weak var ageAdd: UITextField!
    @IBOutlet weak var editName: UILabel!
    @IBOutlet weak var weightAdd: UITextField!
    
    @IBOutlet weak var notificationDescription: UILabel!
    @IBOutlet weak var notificationProfile: UILabel!
    
    @IBOutlet weak var localDescription: UILabel!
    @IBOutlet weak var localProfile: UILabel!
    
    let db = Firestore.firestore()
    
    @IBAction func saveAction(_ sender: Any) {
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        print(currentUser.uid)
        
        
        // Add a new document in collection "cities"
        let age = db.collection("users").document("0foP9Dsc4c7ND4aXZUlG")
        age.updateData(["age": ageAdd.text as Any])
        
        let height = db.collection("users").document("0foP9Dsc4c7ND4aXZUlG")
        height.updateData(["height": heightAdd.text as Any])
        
        let wheight = db.collection("users").document("0foP9Dsc4c7ND4aXZUlG")
        wheight.updateData(["wheight": ageAdd.text as Any])
        
        let adress = db.collection("users").document("0foP9Dsc4c7ND4aXZUlG")
        adress.updateData(["adress": adressAdd.text as Any])
        
        self.performSegue(withIdentifier: "ReturnSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editName.font = editName.font.withSize(28)
        localProfile.font = localProfile.font.withSize(20)
        localDescription.font = localDescription.font.withSize(14)
        notificationProfile.font = notificationProfile.font.withSize(20)
        notificationDescription.font = notificationDescription.font.withSize(14)
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        print(currentUser.uid + "bitasse")
        db.collection("users").whereField("email", isEqualTo: "armel.cantin@orange.fr").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()) ")
                    
                    if let lastName = document.data()["lastName"] as? String{
                        if let firstName = Auth.auth().currentUser?.displayName{
                            self.editName.text = firstName + " " + lastName
                        }
                    }
                    
                    if let height = document.data()["height"] as? String{
                        self.heightAdd.text = height
                    }
                    if let weight = document.data()["weight"] as? String{
                        self.weightAdd.text = weight
                    }
                    if let age = document.data()["age"] as? String{
                        self.ageAdd.text = age
                    }
                    if let home = document.data()["adress"] as? String{
                        self.adressAdd.text = home
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
