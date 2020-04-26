//
//  ViewController.swift
//  Concentration
//
//  Created by Soul on 26/4/2020.
//  Copyright © 2020 Soul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game : Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count+1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of : sender) {
            print(cardNumber)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("cardNumber")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2651281953, green: 0.2651621997, blue: 0.2651086152, alpha: 0) : #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            }
            
        }
    }
    
    private var emojiChoices = ["👻","😈","🎃","😱","🤡","🦇"]
    
    private var emoji = [Int: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4crandom)
        }
        return emoji[card.identifier] ?? "?"
    }
     
}

extension Int {
    var arc4crandom: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
    
}

