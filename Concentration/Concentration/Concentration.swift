//
//  Concentration.swift
//  Concentration
//
//  Created by Soul on 26/4/2020.
//  Copyright © 2020 Soul. All rights reserved.
//

import Foundation

struct Concentration {
    // 只读
    private(set) var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
//                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
//                for faceDownIndex in cards.indices {
//                    cards[faceDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you mast have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
//            cards.append(card) 两次 等价 cards += [card, card]
        }
        // TODO: Shuffle the cards!
    }
    
}
