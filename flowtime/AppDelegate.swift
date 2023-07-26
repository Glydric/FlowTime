//
//  ApplicationDelegate.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 25/07/23.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationWillFinishLaunching(_ notification: Notification) {
		NSApp.setActivationPolicy(.accessory)
		UserDefaults.standard.removeObject(forKey: "progressString")
//		#if DEBUG
//		UserDefaults.standard.set(0, forKey: "actual")
//		#endif
	}
}
