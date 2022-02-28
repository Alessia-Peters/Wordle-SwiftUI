//
//  ContentView.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var appData: AppData
	
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
			
			LazyVGrid(columns: columns) {
				ZStack {
					RoundedRectangle(cornerRadius: 5)
						.stroke(.gray)
						.frame(width: 60, height: 60)
						.foregroundColor(.clear)
					Text(appData.allRows[1][1])
						.font(.system(size: 30))
						
					
				}
			}
		}
		.onTapGesture {
			focus = true
		}
		.onAppear {
			focus = true
		}
	}
	
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let appData = AppData()
		ZStack {
			ContentView(appData: appData)
		}
	}
}
