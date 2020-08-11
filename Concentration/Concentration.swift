//
//  Concentration.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 10/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var cardsRemaining = 0
    init(numberOfPairsOfCards: Int) {
        self.cardsRemaining = numberOfPairsOfCards + 1
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    self.cardsRemaining -= 1
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func areAllCardsFlipped() -> Bool {
        return self.cardsRemaining == 0
    }
    
    func restart() {
        for index in cards.indices {
            cards[index].isFacedUp = false
            cards[index].isMatched = false
        }
        
    }
}
