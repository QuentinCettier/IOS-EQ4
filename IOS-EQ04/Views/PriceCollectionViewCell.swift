//
//  PriceCollectionViewCell.swift
//  IOS-EQ04
//
//  Created by Quentin on 26/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
    
    
    let Label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 23.0)
        label.textColor = UIColor(hex: "F89934")
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(Label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
