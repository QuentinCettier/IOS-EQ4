//
//  HomeView.swift
//  IOS-EQ04
//
//  Created by Quentin on 10/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

import UIKit

class HomeView: UIView{

    let label: UILabel = {
        let lbl = UILabel()
        
        lbl.frame = (CGRect(x: 12, y: 8, width: 100, height: 50))
        lbl.text = people.name
        lbl.textColor = .red
        lbl.numberOfLines = 0
        lbl.backgroundColor = UIColor(hex: "080808")
        lbl.textAlignment = .center
        
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Add all view's items here
        self.addSubview(label)
        setupViewConstraint()
        
        
        
    }
    
    private func setupViewConstraint() {
        //Example of constraints
        //toujours ca
        label.translatesAutoresizingMaskIntoConstraints = false
        
        //Centre le label dans l'ecran et on donne 100*100
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
    }
    
    
}
