//
//  Progress.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 10/04/23.
//

import SwiftUI


struct Profile: Codable, Hashable, Equatable {
	var title: String = ""
	var color: Color = .white
	var record: TimeInterval = 0
	var total: TimeInterval = 0
	
	mutating func reset(){
		total = 0
		record = 0
	}
	
	static func == (lhs: Profile, rhs: Profile) -> Bool {
		return lhs.title == rhs.title
			&& lhs.color == rhs.color
	}
}
