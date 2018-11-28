//
//  PartyViewController.swift
//  IOS-EQ04
//
//  Created by Ryzlane Arsac-Gothière on 27/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class PartyViewController: UIViewController {

    
    @IBOutlet weak var drinkContainer: UIView!
    
    @IBOutlet weak var firstAidButton: UIButton!
    @IBOutlet weak var creditCardButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    @IBOutlet weak var addADrinkButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinkContainer.layer.cornerRadius = 24
        
        addADrinkButton.layer.cornerRadius = 15

        firstAidButton.layer.cornerRadius = 25
        creditCardButton.layer.cornerRadius = 25
        mapButton.layer.cornerRadius = 25
        
    }
}
