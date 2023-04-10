//
//  Progress.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import Foundation

struct ProgressModel: Codable {
	var record: TimeInterval = 0
	var total: TimeInterval = 0
}

extension Encodable {
	var asJson: String? {
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		
		guard let jsonData = try? encoder.encode(self) else { return nil }
		let jsonString = String(data: jsonData, encoding: .utf8)!
		
		return jsonString
	}
}
