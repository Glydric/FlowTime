//
//  NSMenuExtension.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 21/06/23.
//

import Foundation
import AppKit

extension NSMenu {
	convenience init(_ items: [NSMenuItem]) {
		self.init()
		items.forEach(addItem)

	}
}

extension NSMenuItem {
	func withKeyModifier(_ mod: NSEvent.ModifierFlags) -> NSMenuItem {
		self.keyEquivalentModifierMask = mod
		return self
	}
}
