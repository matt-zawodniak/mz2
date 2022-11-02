//
//  EmojiMemoryGame.swift
//  Homework2
//
//  Created by Matt Zawodniak on 10/31/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
//	enum Theme {
//		case animal(String, numberOfCards: Int, color: Color )
//		case vehicle(String, numberOfCards: Int, color: Color )
//		case food(String, numberOfCards: Int, color: Color )
//	}
	
	
	static var emojis = ["🐶","🐹","🐰" ]
	
	static func createMemoryGame() -> MemoryGame<String> {
		MemoryGame<String>(numberOfPairsOfCards: 3) { pairIndex in
			emojis[pairIndex]
			
		}
	}

	@Published private var model : MemoryGame<String> = createMemoryGame()

	// var numberofPairsOfCards: Int?
	// var emojis = Array<String>
	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
}
	
	//MARK: - Intent(s)
	
	func choose(_ card: MemoryGame<String>.Card) {
		model.choose(card)
	}
	
}
