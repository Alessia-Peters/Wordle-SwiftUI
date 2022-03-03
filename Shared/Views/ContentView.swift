//
//  ContentView.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var appData = AppData(limit: 5)
	@FocusState private var focus: Bool
	
	var body: some View {
		ZStack {
			VStack {
				TextField("", text: $appData.guess)
					.opacity(0)
					.disabled(appData.gameWon)
					.disabled(appData.gameOver)
					.focused($focus)
					.disableAutocorrection(true)
					.onSubmit {
						if appData.gameOver != true {
						appData.calculateGuess()
						}
						focus = true
					}
#if os(iOS)
					.textInputAutocapitalization(.never)
					.keyboardType(.alphabet)
#endif
				
				VStack {
					ForEach(0..<6, id: \.self) { row in
						HStack {
							ForEach(0..<5, id: \.self) { cell in
								ZStack {
									RoundedRectangle(cornerRadius: 5)
										.stroke(.gray, lineWidth: 3)
										.frame(width: 52, height: 52)
										.foregroundColor(.clear)
										.opacity(0.6)
									RoundedRectangle(cornerRadius: 5)
										.foregroundColor(appData.getColor(row: row, cell: cell))
										.frame(width: 55, height: 55)
									Text(appData.getCellText(row: row, cell: cell))
										.font(.system(size: 30, weight: .semibold))
										.foregroundColor(appData.getTextColor(row: row))
								}
							}
						}
					}
				}
				HStack {
#if os(iOS)
					Button {
						focus.toggle()
					} label: {
						Image(systemName: "keyboard")
							.font(.system(size: 50))
					}
					.padding(.horizontal)
#endif
					Button {
						appData.startGame()
						focus = true
					} label: {
						ZStack {
							RoundedRectangle(cornerRadius: 10)
								.frame(width: 170, height: 50)
								.foregroundColor(.accentColor)
							Text("New Game")
								.font(.system(size: 25))
								.foregroundColor(Color("Background"))
								.fontWeight(.bold)
						}
					}
					.padding(.horizontal)
					.buttonStyle(.plain)
				}
				.padding()
				.padding(.bottom, 6)
				
			}
			.onAppear {
				self.focus = appData.focus
				appData.startGame()
			}
			.onChange(of: appData.guess) { newValue in
				print(newValue)
				appData.writeGuess(round: appData.round, guess: newValue)
			}
			.onChange(of: focus) { newValue in
				appData.focus = newValue
			}
			.onChange(of: appData.focus) { newValue in
				focus = newValue
			}
			if appData.notEnoughLetters == true {
				PopUpView(appData: appData, text: "Not Enough Letters!", width: 275, color: .accentColor)
			}
			if appData.notValid == true {
				PopUpView(appData: appData, text: "Thats Not a Valid Word!", width: 300, color: .accentColor)
			}
			if appData.gameOver == true {
				PopUpView(appData: appData, text: "You lost!, the word was \(String(appData.currentWord))", width: 260, color: .red)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ZStack {
			ContentView()
			#if os(macOS)
				.frame(width: 380)
			#endif
		}
	}
}
