//
//  AppData.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import Foundation
import SwiftUI

extension ContentView {
	@MainActor class AppData: ObservableObject {
		
		private let limit: Int
		
		init(limit: Int) {
			self.limit = limit
		}
		
		@Published var guess = "" {
			didSet {
				if guess.count > self.limit {
					guess = String(guess.prefix(self.limit))
					self.hasReachedLimit = true
				} else {
					self.hasReachedLimit = false
				}
			}
		}
		@Published var hasReachedLimit = false
		@Published var currentWord: [Character] = [" ", " ", " ", " ", " "]
		@Published var letterRows = [[String]]()
		@Published var answerRows = [[Int]]()
		@Published var notEnoughLetters = false
		@Published var notValid = false
		@Published var round = 0
		@Published var gameWon = false
		
		func startGame() {
			///Resets arrays for a new game
			
			answerRows = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
			letterRows = [[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "]]
			currentWord = createWord()
			guess = ""
			hasReachedLimit = false
			round = 0
			gameWon = false
			print(currentWord)
		}
		
		func createWord() -> [Character] {
			///Selects a random word and turns it into a character array
			
			return Array(Words.answers.randomElement()!)
		}
		
		func writeGuess(round: Int, guess: String) {
			///Writes current guess to corresponding array based on current round
			
			let guessArray: [String] = guess.map {String($0)}
			if guessArray.count <= 5 {
				letterRows[round] = guessArray
			}
		}
		
		
		func getCellText(row: Int, cell: Int) -> String {
			///Returns a specific letter for each cell in view
			
			return letterRows[safe: row]?[safe: cell]?.capitalized ?? " "
		}
		
		func getColor(row: Int, cell: Int) -> Color {
			///Decides what color a tile should be based on answerRows array
			
			switch answerRows[safe: row]?[safe: cell] ?? 0 {
			case let answer where answer == 0:
				return .clear
			case let answer where answer == 1:
				return .green
			case let answer where answer == 2:
				return .yellow
			case let answer where answer == 3:
				return .gray
			default:
				print("Error: Unknown index in getColor method")
				return .clear
			}
		}
		
		func getTextColor(row: Int) -> Color {
			///Decides the color of text
			
			if answerRows[safe: row] == [0,0,0,0,0] {
				return .primary
			} else {
				return .white
			}
		}
		
		func calculateGuess(guessString: String) {
			///Calculates if the guess is correct, if it is the game is won, if it is not it goes onto the next line and marks the answerRows array
			
			print("guess submitted")
			if guessString.count == 5 {
				if guessString.capitalized == String(currentWord).capitalized {
					print("game won")
					gameWon = true
					answerRows[round] = [1,1,1,1,1]
				} else if (Words.guesses.contains(guessString)) || (Words.answers.contains(guessString)) {
					for (guessIndex, guessElement) in guessString.enumerated() {
						for (answerIndex, answerElement) in currentWord.enumerated() {
							if (guessIndex == answerIndex) && (guessElement == answerElement){
									answerRows[round][guessIndex] = 1
									///Right letter right place
							}
						}
						if currentWord.contains(guessElement) && answerRows[round][guessIndex] == 0{
							answerRows[round][guessIndex] = 2
							///Right letter wrong place
						} else if answerRows[round][guessIndex] == 0 {
							answerRows[round][guessIndex] = 3
							///Wrong answer
						}
					}
					guess = ""
					hasReachedLimit = false
					round += 1
				} else {
					print("not a valid word")
					withAnimation {
						notValid.toggle()
					}
				}
			} else {
				print("not enough letters")
				withAnimation {
					notEnoughLetters.toggle()
				}
			}
			print(answerRows)
		}
	}
}
