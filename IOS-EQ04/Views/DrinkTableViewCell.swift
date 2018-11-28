//
//  DrinkTableViewCell.swift
//  IOS-EQ04
//
//  Created by Quentin on 22/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit
import FirebaseFirestore

class DrinkTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        var label = UILabel()
        label.frame = (CGRect(x: 0, y: 0, width: 100, height: 40))
        label.font = UIFont(name: "SFProText-Regular", size: 14.0)
        label.textColor = UIColor(hex: "000000")
        label.numberOfLines = 0
        
        return label
    }()
    
    var drinkIcon: UIImageView = UIImageView(frame: CGRect(x:0,y:0, width:0, height: 0))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addLabel()
        self.addIcon()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func addLabel () {
         addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    }
    
    private func addIcon() {
        addSubview(drinkIcon)
        drinkIcon.translatesAutoresizingMaskIntoConstraints = false
        drinkIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        
        drinkIcon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        drinkIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
        drinkIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7).isActive = true



    }
}
