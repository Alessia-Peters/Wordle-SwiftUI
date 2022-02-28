//
//  WordleApp.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import SwiftUI

@main
struct WordleApp: App {
	@StateObject var appData = AppData()
    var body: some Scene {
        WindowGroup {
			ContentView(appData: appData)
				.onAppear {
					appData.currentWord = appData.createWord()
					appData.setup()
					appData.allRows[1][2] = "B"
					print(appData.allRows)
					
				}
        }
    }
}
