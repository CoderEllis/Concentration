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
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
//            let faceUpCardIndexs = cards.indices.filter { cards[$0].isFaceUp } 
//            return faceUpCardIndexs.count == 1 ? faceUpCardIndexs.first : nil
            
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
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
                if cards[matchIndex] == cards[index] {
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
        cards.shuffle()
//        cards.shuffleArray()
    }
    
    
    
}

extension Array {
    ///随机排序
    mutating func shuffleArray() {
        var data = self
        for i in 1..<self.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                data.swapAt(i, index)
            }
        }
        self = data
    }
    
    mutating func shuffleArray2() {
        var data = self
        var data2 = Array<Element>()
        while data.count != 0 {
            let i = arc4random_uniform(UInt32(data.count))
            data2.append(data[Int(i)])
            data.remove(at: Int(i))
        }
        self = data2
    }
    
}

extension Collection {
    var oneAndOnly : Element? {
        return count == 1 ? first : nil
    }
    
}
