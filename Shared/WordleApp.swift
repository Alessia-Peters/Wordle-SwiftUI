//
//  WordleApp.swift
//  Wordle
//
//  Created by Alessia on 27/2/2022.
//

import SwiftUI

#if os(macOS)
@main
struct WordleApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	var body: some Scene {
		WindowGroup {
			ContentView()
				.frame(width: 380)
		}
		.windowStyle(.hiddenTitleBar)
		.windowToolbarStyle(.unified)
	}
}

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		return true
	}
}

#else
@main
struct WordleApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}
#endif

