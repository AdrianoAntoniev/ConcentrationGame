//
//  GameThemes.swift
//  Concentration
//
//  Created by Adriano Rodrigues Vieira on 11/08/20.
//  Copyright © 2020 Adriano Rodrigues Vieira. All rights reserved.
//

import UIKit

struct GameThemes {
    private static var halloweenTheme = GameTheme(backgroundColor: .black,
                                                  buttonBackgroundColorAndLabelTextColor: .orange,
                                                  emojiChoice: ["🦇", "🕸", "🧟‍♂️", "😈", "🎃", "👻", "🧛🏻‍♂️", "👹", "💀"])
    
    private static var sportsTheme = GameTheme(backgroundColor: .cyan,
                                               buttonBackgroundColorAndLabelTextColor: .brown,
                                               emojiChoice: ["⚽️", "🏀", "🏈", "🥊", "🏸", "🏓", "🥎", "🏋️", "🏄‍♂️"])
    
    private static var foodTheme = GameTheme(backgroundColor: .red,
                                               buttonBackgroundColorAndLabelTextColor: .yellow,
                                               emojiChoice: ["🥩", "🍕", "🧆", "🍗", "🥮", "🍱", "🍫", "☕️", "🥐"])
    
    private static var smileyTheme = GameTheme(backgroundColor: .yellow,
                                               buttonBackgroundColorAndLabelTextColor: .blue,
                                               emojiChoice: ["😃", "😅", "😇", "😍", "🥰", "🤪", "🤩", "😡", "🥶"])
    
    private static var animalTheme = GameTheme(backgroundColor: .brown,
                                               buttonBackgroundColorAndLabelTextColor: .green,
                                               emojiChoice: ["🐵", "🐮", "🦁", "🐼", "🐶", "🐭", "🐱", "🐰", "🐨"])
    
    private static var flagTheme = GameTheme(backgroundColor: .magenta,
                                               buttonBackgroundColorAndLabelTextColor: .white,
                                               emojiChoice: ["🇿🇦", "🇩🇪", "🇦🇲", "🇦🇹", "🇧🇷", "🇨🇳", "🇺🇸", "🇪🇸", "🇫🇷"])
    
    
    private static var themes: [GameTheme] = [halloweenTheme, sportsTheme, foodTheme, smileyTheme, animalTheme, flagTheme]
    
    static func getThemeForGame() -> GameTheme {
        let upperBound = themes.count
        return themes[Int(arc4random_uniform(UInt32(upperBound)))]
    }
}
