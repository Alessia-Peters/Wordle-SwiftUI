//
//  PopUpView.swift
//  Wordle
//
//  Created by Alessia on 2/3/2022.
//

import SwiftUI

struct PopUpView: View {
	@ObservedObject var appData: ContentView.AppData
	var text: String
	var width: CGFloat
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.foregroundColor(.white)
			RoundedRectangle(cornerRadius: 10)
				.opacity(0.7)
				.transition(.opacity)
				.foregroundColor(.accentColor)
				.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation {
							if appData.notEnoughLetters == true {
							appData.notEnoughLetters = false
							} else {
								appData.notValid = false
							}
						}
					}
				}
			
			Text(text)
				.foregroundColor(.white)
				.font(.system(size: 25))
				.fontWeight(.bold)
		}
		.offset(y: -127)
		.frame(width: width, height: 70)
		.zIndex(5)
	}
}

struct PopUpView_Previews: PreviewProvider {
	static var previews: some View {
		PopUpView(appData: ContentView.AppData(limit: 5), text: "Not Enough Letters!", width: 275)
	}
}
