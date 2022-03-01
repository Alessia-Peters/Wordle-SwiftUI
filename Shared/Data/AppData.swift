//
//  AppData.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import Foundation

extension ContentView {
	@MainActor class AppData: ObservableObject {
		@Published var currentWord: [Character] = [" ", " ", " ", " ", " "]
		@Published var allRows = [[String]]()
		@Published var guess = String()
		
		
		func createWord() -> [Character] {
			return Array(Words.answers.randomElement()!)
		}
		
		func writeGuess(round: Int, guess: String) {
			///Writes current guess to corresponding array based on current round
			
			let guessArray: [String] = guess.map {String($0)}
			if guessArray.count <= 5 {
				allRows[round] = guessArray
			}
		}
		
		
		func getCellText(row: Int, cell: Int) -> String {
			let text = allRows
			return text[safe: row]?[safe: cell] ?? " "
		}
		
		func setup() {
			let rowZero = ["1","2","3","4","5"]
			let rowOne = ["6","7","8","9","10"]
			let rowTwo = ["11","12","13","14","15"]
			let rowThree = ["16","17","18","19","20"]
			let rowFour = ["21","22","23","24","25"]
			let rowFive = ["26","27","28","29","30"]
			
			allRows.append(contentsOf: [rowZero, rowOne, rowTwo, rowThree, rowFour, rowFive])
		}
	}
}
