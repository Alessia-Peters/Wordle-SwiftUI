//
//  Extentions.swift
//  Wordle
//
//  Created by Alessia on 2/3/2022.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
	subscript (safe index: Index) -> Iterator.Element? {
		return indices.contains(index) ? self[index] : nil
	}
}

