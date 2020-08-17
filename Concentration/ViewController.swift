//
//  ViewController.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 10/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private var theme: GameTheme = GameThemes.getThemeForGame()
    private var emojiChoices = ""
    private var isEndGame = false
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : theme.buttonBackgroundColorAndLabelTextColor
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        restartView()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            if !isEndGame {
                flipCount += 1
                score = game.getScore(gameIsRestarted: false)
            }
            
            if game.areAllCardsFlipped() {
                flipCountLabel.text = "You got \(game.getScore(gameIsRestarted: false)) points!"
                isEndGame = true
            }
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.580126236, blue: 0.01286631583, alpha: 0) : theme.buttonBackgroundColorAndLabelTextColor
            }
        }
    }
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
    
    
    @IBAction private func newGamePressed(_ sender: UIButton) {
        game.restart()
        self.restartView()
        self.flipCount = 0
        emoji = [Card: String]()
        self.updateViewFromModel()
    }
    
    private func restartView() {
        isEndGame = false
        theme = GameThemes.getThemeForGame()
        score = game.getScore(gameIsRestarted: true)
        
        view.backgroundColor = theme.backgroundColor
        emojiChoices = theme.emojiChoice
        
        cardButtons.forEach { (card) in
            card.backgroundColor = theme.buttonBackgroundColorAndLabelTextColor
        }
        
        newGameButton.backgroundColor = theme.backgroundColor
        newGameButton.setTitleColor(theme.buttonBackgroundColorAndLabelTextColor, for: .normal)
        flipCountLabel.backgroundColor = theme.backgroundColor
        flipCountLabel.textColor = theme.buttonBackgroundColorAndLabelTextColor
        scoreLabel.backgroundColor = theme.backgroundColor
        scoreLabel.textColor = theme.buttonBackgroundColorAndLabelTextColor
    }
}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
