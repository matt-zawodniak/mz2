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
			HStack{
				Text(EmojiMemoryGameViewModel.selectedTheme!.name).font(.largeTitle).padding()
				Spacer()
				VStack{
					Text("Score")
					ZStack{
						RoundedRectangle(cornerRadius: 20)
							.fill().foregroundColor(.white)
							.frame(width: 50, height: 50)
						RoundedRectangle(cornerRadius: 20)
							.strokeBorder(lineWidth: 3)
							.frame(width: 50, height: 50)
						Text(viewModel.score)
					}
				}.frame(height: 100)

			}
			ScrollView {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
					ForEach(viewModel.cards) { card in CardView(card: card)
							.aspectRatio(2/3, contentMode: .fit)
							.onTapGesture {
								viewModel.choose(card)
							}
					}
				}
			}
			.padding(.vertical)

				Button("New Game", action: {
					viewModel.newGame()
				})
				.padding(.horizontal)
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
