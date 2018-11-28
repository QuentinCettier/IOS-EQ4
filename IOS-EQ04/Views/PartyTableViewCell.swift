//
//  PartyTableViewCell.swift
//  IOS-EQ04
//
//  Created by Ryzlane Arsac-Gothière on 25/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {

    @IBOutlet weak var partyLitresLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    
    
    func setParty(party: Party) {
        partyLitresLabel.text = "\(party.litres) L"
        partyDateLabel.text = party.date
    }
}
