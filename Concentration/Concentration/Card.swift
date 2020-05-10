//
//  Card.swift
//  Concentration
//
//  Created by Soul on 26/4/2020.
//  Copyright © 2020 Soul. All rights reserved.
//

import Foundation

struct Card : Hashable 
{
// hashValue 已不再要求必须实现了, 由上面hash(into:)代替
//    var hashValue : Int { return identifier }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier) 
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
