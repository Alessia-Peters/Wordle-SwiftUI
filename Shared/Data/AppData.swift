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
		@Published var completedLetters = [[Character]]()
		@Published var answerRows = [[Int]]()
		@Published var notEnoughLetters = false
		@Published var notValid = false
		@Published var round = 0
		@Published var gameWon = false
		@Published var gameOver = false
		@Published var focus = true
		
		func startGame() {
			///Resets arrays for a new game
			
			withAnimation {
				gameOver = false
			}
			answerRows = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
			letterRows = [[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "],[" "," "," "," "," "]]
			currentWord = createWord()
			guess = ""
			hasReachedLimit = false
			round = 0
			gameWon = false
			focus = true
			print(currentWord)
		}
		
		func createWord() -> [Character] {
			///Selects a random word and turns it into a character array
			
			return Array(Words.answers.randomElement()!)
		}
		
		func writeGuess(round: Int, guess: String) {
			///Writes current guess to corresponding array based on current round
			
			let guessArray: [String] = guess.map {String($0)}
			if (guessArray.count <= 5) && (round <= 5){
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
		
		func assignColors() {
			/// Calculates which color to assign letters according to the how correct it is
			
			for (guessIndex, guessElement) in guess.enumerated() {
				for (answerIndex, answerElement) in currentWord.enumerated() {
					if (guessIndex == answerIndex) && (guessElement == answerElement){
						answerRows[round][guessIndex] = 1
						completedLetters[round][guessIndex] = guessElement
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
		}
		
		func calculateGuess() {
			///Calculates if the guess is correct, and send the popups if there isnt enugh letters or the word isnt valid
			
			print("guess submitted")
			if guess.count == 5{
				if guess.capitalized == String(currentWord).capitalized {
					print("game won")
					gameWon = true
					answerRows[round] = [1,1,1,1,1]
				} else if (Words.guesses.contains(guess)) || (Words.answers.contains(guess)) {
					assignColors()
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
			if (answerRows.index(after: round) == 7) {
				withAnimation {
					gameOver = true
				}
			}
			print(answerRows)
		}
	}
}
