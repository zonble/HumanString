import Foundation

/// A helper that makes using Regular Expression easier.
public class Regex {

	/// Find all matches in a string with a given pattern.
	/// - Parameters:
	///   - pattern: The pattern.
	///   - string: The string.
	///   - options: The options to build the `NSRegularExpression` object.
	///   - matchingOptions: The options for matching.
	/// - Throws: The errors that could happen during creating the `NSRegularExpression` object.
	/// - Returns: The matches.
	static func findAll(pattern: String,
						string: String,
						options: NSRegularExpression.Options = [],
						matchingOptions: NSRegularExpression.MatchingOptions = []
						) throws -> [Match] {
		let regex = try NSRegularExpression(pattern: pattern, options: options)
		let matches = regex.matches(in: string, options: matchingOptions, range: NSMakeRange(0, string.count))
		return matches.map {
			return Match($0, string)
		}
	}
}

/// Represents the matches.
public class Match {
	/// The string.
	public private (set) var string : String
	/// The `NSTextCheckingResult` object.
	public private (set) var checkResult : NSTextCheckingResult

	fileprivate init(_ checkResult : NSTextCheckingResult, _ string: String) {
		self.checkResult = checkResult
		self.string = string
	}

	public func groups() -> [String] {
		let ranges = self.checkResult.numberOfRanges
		return (0..<ranges).map { index in
			let range = self.checkResult.range(at: index)
			return self.string.substring(with: range.location..<(range.location + range.length)) ?? ""
		}
	}

	public func group(at index: Int) -> String? {
		if index >= self.checkResult.numberOfRanges {
			return nil
		}
		let range = self.checkResult.range(at: index)
		return self.string.substring(with: range.location..<(range.location + range.length))
	}
}
