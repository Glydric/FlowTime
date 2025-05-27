//
//  CodableColor.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 26/07/23.
//

import SwiftUI

extension Color: Codable {
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try! container.encode(self.cgColor?.components)
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let values = try container.decode([CGFloat].self)
		
		self.init(.sRGB, red: values[0], green: values[1], blue: values[2])
	}
	
	
}
