//
//  Image.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 18/08/23.
//

import SwiftUI

extension Image{
	init?(systemName: String, withConfiguration configuration: NSImage.SymbolConfiguration){
		guard
			let nsImage = NSImage(systemSymbolName: "timer", accessibilityDescription: nil),
			let nsImage = nsImage.withSymbolConfiguration(configuration)
		else { return nil }
		self.init(nsImage: nsImage)
	}
	
	/// This is used in Menu Bar Extra icon to force the color
	init?(systemName: String, withHierarchicalColor color: NSColor){
		self.init(
			systemName: systemName,
			withConfiguration: NSImage
				.SymbolConfiguration(pointSize: 16, weight: .light)
				.applying(.init(hierarchicalColor: color))
		)
	}
	
	/// This is used in Menu Bar Extra icon to force the color
	init?(systemName: String, withHierarchicalColor color: Color){
		self.init(
			systemName: systemName,
			withHierarchicalColor: color.nsColor
		)
	}
}
