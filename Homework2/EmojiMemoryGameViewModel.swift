//
//  EmojiMemoryGame.swift
//  Homework2
//
//  Created by Matt Zawodniak on 10/31/22.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
	
	struct Theme {
		var name : String
		var emojis : Array<String> // = ["🐶","🐹","🐰" ]
		var color : Color //= Color.purple
		var difficulty : Int //= 3
		// create a initializer that takes everything we need
	}
	static var themes = [Theme(name: "Animals", emojis: ["🐶","🐹","🐰" ], color: Color.red, difficulty: 3),
						 Theme(name: "Sports", emojis: ["🏈","⚾️","🎾","🏐","🏉"], color: Color.purple, difficulty: 4),
						 Theme(name: "Fruits and Vegetables", emojis: ["🍎","🍐","🍊","🍌","🍉","🍒","🥑","🥦"], color: Color.green, difficulty: 5)]
	
	static var selectedTheme = themes.randomElement()//choose one at random

	//static var emojis = ["🐶","🐹","🐰" ]
		
	static func createMemoryGame() -> MemoryGameModel<String> {
		MemoryGameModel<String>(numberOfPairsOfCards: selectedTheme!.difficulty) { pairIndex in
			selectedTheme!.emojis[pairIndex]
		}
	}
			
	@Published private var model : MemoryGameModel<String> = createMemoryGame()
	
	//var numberofPairsOfCards: Int?
	//var emojis = Array<String>
	var cards: Array<MemoryGameModel<String>.Card> {
		return model.cards
	}
	
	var score: String {
		return String(model.score)
	}
	//MARK: - Intent(s)
	
	func choose(_ card: MemoryGameModel<String>.Card) {
		model.choose(card)
	}
	
	func newGame() {
		EmojiMemoryGameViewModel.selectedTheme = EmojiMemoryGameViewModel.themes.randomElement()
		model = EmojiMemoryGameViewModel.createMemoryGame()
		}
}
