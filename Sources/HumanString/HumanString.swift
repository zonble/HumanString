import Foundation

/// The errors that coould happen in HumanString library.
public enum HumanStringError : Error, LocalizedError {
	/// The range is invalid.
	case invalidRange

	public var errorDescription: String? {
		switch self {
		case .invalidRange:
			return "The range is invalid."
		}
	}
}

extension String {
	func convert(_ i: Int) -> String.Index {
		return i < 0 ? self.index(self.endIndex, offsetBy: i) : self.index(self.startIndex, offsetBy: i)
	}

	func convert(_ r:PartialRangeFrom<Int>) -> PartialRangeFrom<String.Index> {
		return convert(r.lowerBound)...
	}

	func convert(_ r:PartialRangeUpTo<Int>) -> PartialRangeUpTo<String.Index> {
		return ..<convert(r.upperBound)
	}

	func convert(_ r:PartialRangeThrough<Int>) -> PartialRangeThrough<String.Index> {
		return ...convert(r.upperBound)
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

public extension String {

	/// Returns a character at the given index.
	/// - Parameter i: The index.
	subscript(i: Int) -> Character {
		return self[convert(i)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	subscript(r: PartialRangeFrom<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	subscript(r: PartialRangeUpTo<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	subscript(r: PartialRangeThrough<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	subscript(r: ClosedRange<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	subscript(r: Range<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}
}

public extension String {

	func substring(from index: Int) -> String? {
		if let substring = self[index...] {
			return String(substring)
		}
		return nil
	}

	func substring(to index: Int) -> String? {
		if let substring =  self[..<index] {
			return String(substring)
		}
		return nil
	}

	func substring(with aRange: Range<Int>) -> String? {
		if let substring = self[aRange.startIndex..<aRange.endIndex] {
			return String(substring)
		}
		return nil
	}

}

public extension String {
	/// Returns a `String.Index` object at the given index.
	/// - Parameter i: the index.
	func index(at i: Int) -> String.Index {
		return convert(i)
	}
}

public extension String {
	mutating func insert(_ newElement: __owned Character, at i: Int) {
		self.insert(newElement, at: convert(i))
	}

	mutating func remove(at position: Int) -> Character {
		return self.remove(at: convert(position))
	}

	mutating func removeSubrange(_ bounds: Range<Int>) {
		guard let range = convert(bounds) else {
			return
		}
		self.removeSubrange(range)
	}
}
