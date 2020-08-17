//
//  Concentration.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 10/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFacedUp {
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
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    var cardsRemaining = 0
    var cardsFlippedOnce = [Card]()
    private var score = 0
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): You must have at least one pair of cards  ")
        self.cardsRemaining = numberOfPairsOfCards
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    self.cardsRemaining -= 1
                    
                    self.score += 2
                }
                // Coloquei aqui esta linha para colocar duas cartas diferentes no array (cartas erradas)
                else {
                    if !cardsFlippedOnce.contains(cards[matchIndex]) {
                        cardsFlippedOnce.append(cards[matchIndex])
                    } else {
                        score -= 1
                    }
                    
                    if !cardsFlippedOnce.contains(cards[index]) {
                        cardsFlippedOnce.append(cards[index])
                    } else {
                        self.score -= 1
                    }
                }
                cards[index].isFacedUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func areAllCardsFlipped() -> Bool {
        return self.cardsRemaining == 0
    }
    
    mutating func restart() {
        for index in cards.indices {
            cards[index].isFacedUp = false
            cards[index].isMatched = false
        }
        
        self.cardsRemaining = (cards.count / 2) + 1
        cardsFlippedOnce = [Card]()
        
    }
    
    mutating func getScore(gameIsRestarted: Bool) -> Int {
        if gameIsRestarted {
            self.score = 0
        }
        
        return self.score
    }
}
