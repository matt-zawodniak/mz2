//
//  Homework2App.swift
//  Homework2
//
//  Created by Matt Zawodniak on 8/27/22.
//

import SwiftUI

@main
struct Homework2App: App {
	let game = EmojiMemoryGameViewModel()
	
    var body: some Scene {
        WindowGroup {
			ContentView(viewModel: game)
        }
    }
}
