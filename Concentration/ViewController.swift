//
//  ViewController.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 10/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var theme: GameTheme = GameThemes.getThemeForGame()
    var emojiChoices: [String] = []
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    override func viewDidLoad() {
        restartView()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            flipCount += 1
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                if game.areAllCardsFlipped() {
                    flipCountLabel.text = "You made \(flipCount) flips."
                    break
                }
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.580126236, blue: 0.01286631583, alpha: 0) : theme.buttonBackgroundColorAndLabelTextColor
            }
        }
    }
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    
    @IBAction func newGamePressed(_ sender: UIButton) {
        game.restart()
        self.restartView()
        self.flipCount = 0
        self.emoji = [Int: String]()
        self.updateViewFromModel()
    }
    
    func restartView() {
        theme = GameThemes.getThemeForGame()
        
        view.backgroundColor = theme.backgroundColor
        emojiChoices = theme.emojiChoice
        
        cardButtons.forEach { (card) in
            card.backgroundColor = theme.buttonBackgroundColorAndLabelTextColor
        }
        
        newGameButton.backgroundColor = theme.backgroundColor
        newGameButton.setTitleColor(theme.buttonBackgroundColorAndLabelTextColor, for: .normal)
        flipCountLabel.backgroundColor = theme.backgroundColor
        flipCountLabel.textColor = theme.buttonBackgroundColorAndLabelTextColor
    }
}


