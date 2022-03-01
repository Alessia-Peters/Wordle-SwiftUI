//
//  ContentView.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var appData = AppData()
	
	@FocusState private var focus: Bool
	
	@State var guess: String = ""
	@State var round = 0
	
	private let columns = [
		GridItem(),
		GridItem(),
		GridItem(),
		GridItem(),
		GridItem(),
		GridItem()
	]
	
	var body: some View {
		VStack {
			TextField("", text: $guess)
				.opacity(0)
				.focused($focus)
				.disableAutocorrection(true)
				.textInputAutocapitalization(.never)
				.keyboardType(.alphabet)
			
			
			VStack {
				ForEach(0..<6, id: \.self) { row in
					HStack {
						ForEach(0..<5, id: \.self) { cell in
								ZStack {
									RoundedRectangle(cornerRadius: 5)
										.stroke(.gray)
										.frame(width: 60, height: 60)
										.foregroundColor(.clear)
									Text(appData.getCellText(row: row, cell: cell))
										.font(.system(size: 30))
							}
						}
					}
				}
			}
		}
		.onTapGesture {
			focus = true
		}
		.onAppear {
			appData.currentWord = appData.createWord()
			appData.setup()
		}
		.onChange(of: guess) { newValue in
			appData.writeGuess(round: round, guess: newValue)
			guess = appData.guess
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			ContentView()
		}
	}
}
