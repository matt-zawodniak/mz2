//
//  ContentView.swift
//  Homework2
//
//  Created by Matt Zawodniak on 8/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
	
	var body: some View{
		VStack{
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
					ForEach(viewModel.cards) { card in CardView(card: card)
							.aspectRatio(2/3, contentMode: .fit)
							.onTapGesture {
								viewModel.choose(card)
							}
					}
				}
			}
			Button("New Game", action: {
				viewModel.newGame()
				}) //This button changes the theme but doesn't rebuild the memory game, so you can only see the color changing
			
			}
			.foregroundColor(EmojiMemoryGameViewModel.selectedTheme?.color)
			.padding(.horizontal)
			
		}
	}

struct CardView: View{
	let card: MemoryGameModel<String>.Card
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 20)
			if card.isFaceUp {
				shape.fill().foregroundColor(.white)
				shape.strokeBorder(lineWidth :3)
				Text(card.content).font(.largeTitle)
			} else if card.isMatched {
				shape.opacity(0)
			}
			else {
				shape.fill()
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let game = EmojiMemoryGameViewModel()
		ContentView(viewModel: game)
    }
}
