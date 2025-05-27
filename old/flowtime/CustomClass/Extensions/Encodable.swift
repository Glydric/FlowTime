//
//  Encodable.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 21/06/23.
//

import Foundation

extension Encodable {
	var asJson: String? {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		
		guard let jsonData = try? encoder.encode(self) else { return nil }
		let jsonString = String(data: jsonData, encoding: .utf8)!
		
		return jsonString
	}
}
