//
//  TextLimiter.swift
//  Wordle
//
//  Created by Alessia on 2/3/2022.
//

import Foundation

class TextLimiter: ObservableObject {
	private let limit: Int
	
	init(limit: Int) {
		self.limit = limit
	}
	
	@Published var value = ""
	@Published var hasReachedLimit = false
}
