//
//  AppData.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import Foundation

class AppData: ObservableObject {
	@Published var currentWord: [Character] = [" ", " ", " ", " ", " "]
	@Published var allRows = [[String]]()


	func createWord() -> [Character] {
		return Array(Words.answers.randomElement()!)
	}
	
//	@Published var rowOne: [Character] = ["a"]
//	@Published var rowTwo: [Character] = ["a"]
//	@Published var rowThree: [Character] = ["a"]
//	@Published var rowFour: [Character] = ["a"]
//	@Published var rowFive: [Character] = ["a"]
//	@Published var rowSix: [Character] = ["a"]
	
		
//	func cellText(row: Int, round: Int, guess: String) -> String{
//		///Calculates what the text should be in the corresponding cells
//
//		var text = " "
//
//		if round == row {
//			text = guess
//		} else if round < row {
//			text = " "
//		} else if round > row {
//			text = writtenGuesses(row: row)
//		}
//
//		func writtenGuesses(row: Int) -> String {
//			///Retrives stored values based on current row
//
//			var text = String()
//			switch row {
//			case 0: text = rowZero
//			case 1: text = rowOne
//			case 2: text = rowTwo
//			case 3: text = rowThree
//			case 4: text = rowFour
//			case 5: text = rowFive
//			default:
//				print("Error: round value above 6")
//			}
//			return text
//		}
//
//		return text
//	}
//
//	func writeGuess(round: Int, guess: String) {
//		///Writes current guess to corresponding array based on current round
//
//		switch round {
//		case 0: rowZero = guess
//		case 1: rowOne = guess
//		case 2: rowTwo = guess
//		case 3: rowThree = guess
//		case 4: rowFour = guess
//		case 5: rowFive = guess
//		default:
//			print("Error: round value above 6")
//		}
//	}
	
	func setup() {
		var rowZero = [" "," "," "," "," "]
		var rowOne = [" "," "," "," "," "]
		var rowTwo = [" "," "," "," "," "]
		var rowThree = [" "," "," "," "," "]
		var rowFour = [" "," "," "," "," "]
		var rowFive = [" "," "," "," "," "]
		
		allRows.append(contentsOf: [rowZero, rowOne, rowTwo, rowThree, rowFour, rowFive])
		
		print(allRows)
	}
}
