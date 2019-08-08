import Foundation

public enum HumanStringError : Error, LocalizedError {
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
		if i < 0 {
			return self.index(self.endIndex, offsetBy: i)
		}
		return self.index(self.startIndex, offsetBy: i)
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

extension String {

	/// Returns a character at the given index.
	/// - Parameter i: The index.
	public subscript(i: Int) -> Character {
		return self[convert(i)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	public subscript(r: PartialRangeFrom<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	public subscript(r: PartialRangeUpTo<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	public subscript(r: PartialRangeThrough<Int>) -> Substring? {
		return self[convert(r)]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	public subscript(r: ClosedRange<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}

	/// Returns a character at the given range.
	/// - Parameter r: The range.
	public subscript(r: Range<Int>) -> Substring? {
		guard let range = convert(r) else {
			return nil
		}
		return self[range]
	}
}

extension String {
	/// Returns a `String.Index` object at the given index.
	/// - Parameter i: the index.
	public func index(at i: Int) -> String.Index {
		return convert(i)
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

extension String.Index {
	static func + (left: String.Index, right: (String, Int) ) -> String.Index {
		return right.0.index(left, offsetBy: right.1)
	}
}
