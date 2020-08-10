//
//  ViewController.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 10/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var flipCount: Int
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCard(withEmoji: "👻", on: sender)
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle("👻", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}


