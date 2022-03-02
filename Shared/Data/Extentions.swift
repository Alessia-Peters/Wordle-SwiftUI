//
//  Extentions.swift
//  Wordle
//
//  Created by Alessia on 2/3/2022.
//

import SwiftUI

extension Collection where Indices.Iterator.Element == Index {
	///Makes indexes of arrays not throw errors
	
	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
