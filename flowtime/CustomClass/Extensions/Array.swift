//
//  Array.swift
//  FlowTime
//
//  Created by Leonardo Migliorelli on 26/07/23.
//

import Foundation
extension Array where Element: Equatable{
	mutating func removeFirst(_ element: Element) -> Element? {
		if let index = self.firstIndex(of: element){
			return self.remove(at: index)
		}
		return nil
	}
	func append(_ element: Element?){
		if let element { append(element) }
	}
	mutating func replace(_ element: Element, at index: Int){
		remove(at: index)
		insert(element, at: index)
	}
}

extension Array where Element: Hashable {
	/// this is a secure function to remove duplicates without use Set, so the order is respected
	mutating func removeDuplicates() -> Array {
		var toKeep = Array(Set(self))
		
		// se $0 esiste in toKeep allora lo aggiungiamo a newArray rimuovendolo da toKeep, alla prossima coincidenza dello stesso valore toKeep non avrà più il valore e per ciò non lo aggiungerà a newArray
		self = filter { $0 == toKeep.removeFirst($0) }
		
		return self
	}
}

extension Array: RawRepresentable where Element: Codable {
	public init?(rawValue: String) {
		guard
			let data = rawValue.data(using: .utf8),
			let result = try? JSONDecoder().decode([Element].self, from: data)
		else { return nil }
		
		self = result
	}
	
	public var rawValue: String {
		guard
			let data = try? JSONEncoder().encode(self),
			let result = String(data: data, encoding: .utf8)
		else { return "[]" }
		
		return result
	}
}
