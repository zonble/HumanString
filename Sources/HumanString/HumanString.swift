import Foundation

public enum HumanStringError : Error {
	case invalidRange
}

extension String {
	func convert(_ i: Int) -> String.Index {
		if i < 0 {
			return self.index(self.endIndex, offsetBy: i)
		}
		return self.index(self.startIndex, offsetBy: i)
	}

	func convert(_ r:ClosedRange<Int>) -> ClosedRange<String.Index>? {
		if r.lowerBound < 0 && r.upperBound < 0 {
			let lowerBound = self.index(self.endIndex, offsetBy: r.lowerBound)
			let upperBound = self.index(self.endIndex, offsetBy: r.upperBound)
			return lowerBound...upperBound
		} else if r.lowerBound >= 0 && r.upperBound >= 0 {
			let lowerBound = self.index(self.startIndex, offsetBy: r.lowerBound)
			let upperBound = self.index(self.startIndex, offsetBy: r.upperBound)
			return lowerBound...upperBound
		}
		return nil
	}

	func convert(_ r:Range<Int>) -> Range<String.Index>? {
		if r.lowerBound <= 0 && r.upperBound <= 0 {
			let lowerBound = self.index(self.endIndex, offsetBy: r.lowerBound)
			let upperBound = self.index(self.endIndex, offsetBy: r.upperBound)
			return lowerBound..<upperBound
		} else if r.lowerBound >= 0 && r.upperBound >= 0 {
			let lowerBound = self.index(self.startIndex, offsetBy: r.lowerBound)
			let upperBound = self.index(self.startIndex, offsetBy: r.upperBound)
			return lowerBound..<upperBound
		}
		return nil
	}
}

extension String {
	public subscript(i: Int) -> Character {
		return self[convert(i)]
	}

	public subscript(r: ClosedRange<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}

	public subscript(r: Range<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}
}

extension String {
	public mutating func insert(_ newElement: __owned Character, at i: Int) {
		self.insert(newElement, at: convert(i))
	}

	public mutating func remove(at position: Int) -> Character {
		return self.remove(at: convert(position))
	}

	public mutating func removeSubrange(_ bounds: Range<Int>) {
		guard let range = convert(bounds) else {
			return
		}
		self.removeSubrange(range)
	}
}

