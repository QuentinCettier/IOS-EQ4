//
//  Drink.swift
//  IOS-EQ04
//
//  Created by Quentin on 22/11/2018.
//  Copyright © 2018 EQ4. All rights reserved.
//

struct Drink {
    var name: String?
    var degre: Int?
    var image: String?
    
    init?(dictionary: [String: Any]) {
        
        self.name = dictionary["name"] as? String
        self.degre = dictionary["degre"] as? Int
        self.image = dictionary["image"] as? String
    }
}

struct RegisteredDrink {
    var date: String?
    var drinkName: String?
    var drinkPrice: String?
    var drinkSize: String?
    
    
    init?(dictionary: [String: Any]) {
        
        self.date = dictionary["date"] as? String
        self.drinkName = dictionary["drinkName"] as? String
        self.drinkPrice = dictionary["drinkPrice"] as? String
        self.drinkSize = dictionary["drinkSize"] as? String
    }
}
