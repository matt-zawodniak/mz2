//
//  MemoryGame.swift
//  Homework2
//
//  Created by Matt Zawodniak on 8/27/22.
//

import Foundation
import SwiftUI

struct MemoryGameModel<CardContent> where CardContent: Equatable {
	private(set) var cards: Array<Card>
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int?
	
	mutating func choose(_ card: Card) {
		if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}), !cards[chosenIndex].isFaceUp,
			!cards[chosenIndex].isMatched
		{
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				if cards[chosenIndex].content == cards[potentialMatchIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
					score += 2
				}
				indexOfTheOneAndOnlyFaceUpCard = nil
				if cards[chosenIndex].isSeen == true {
					if cards[chosenIndex].isMatched == false {
						score -= 1
					}
				}
			} else {
				for index in cards.indices {
					cards[index].isFaceUp = false
				}
				indexOfTheOneAndOnlyFaceUpCard = chosenIndex

			}
			cards[chosenIndex].isSeen = true
			cards[chosenIndex].isFaceUp.toggle()
		}
	}
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		cards = Array<Card>()
		// add numberOfPairsOfCards x 2 cards to card array
		for pairIndex in 0..<numberOfPairsOfCards {
			let content = createCardContent(pairIndex)
			cards.insert(Card(content: content, id: pairIndex*2), at: Int.random(in: 0..<cards.count+1))
			cards.insert(Card(content: content, id: pairIndex*2+1), at: Int.random(in: 0..<cards.count+1))
		}
	}
	
	var score: Int = 0
	
	struct Card: Identifiable {
		var isFaceUp = false
		var isMatched = false
		var content: CardContent
		var id: Int
		var isSeen = false
	}
}
