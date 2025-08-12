import Foundation

/// A helper that makes using Regular Expression easier.
public struct Regex {

    /// Find all matches in a string with a given pattern.
    /// 
    /// - Parameters:
    ///   - pattern: The pattern.
    ///   - string: The string.
    ///   - options: The options to build the `NSRegularExpression` object.
    ///   - matchingOptions: The options for matching.
    /// - Throws: The errors that could happen during creating the `NSRegularExpression` object.
    /// - Returns: The matches.
    public static func findAll(pattern: String,
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

    /// Find the first match in a string with a given pattern.
    ///
    /// - Parameters:
    ///   - pattern: The pattern.
    ///   - string: The string.
    ///   - options: The options to build the `NSRegularExpression` object.
    ///   - matchingOptions: The options for matching.
    /// - Throws: The errors that could happen during creating the `NSRegularExpression` object.
    /// - Returns: The first match.
    public func findFirst(pattern: String,
                          string: String,
                          options: NSRegularExpression.Options = [],
                          matchingOptions: NSRegularExpression.MatchingOptions = []
    ) throws -> Match? {
        let regex = try NSRegularExpression(pattern: pattern, options: options)
        guard let result = regex.firstMatch(in: string, options: matchingOptions, range: NSMakeRange(0, string.count)) else {
            return nil
        }
        return Match(result, string)
    }

    /// Makes a new string by replacing the matches with a template.
    ///
    /// - Parameters:
    ///   - pattern: The pattern.
    ///   - string: The string.
    ///   - template: The template.
    ///   - options: The options to build the `NSRegularExpression` object.
    ///   - matchingOptions: The options for matching.
    /// - Throws: The errors that could happen during creating the `NSRegularExpression` object.
    /// - Returns: The replaced string.
    public func replace(pattern: String,
                        string: String,
                        template: String,
                        options: NSRegularExpression.Options = [],
                        matchingOptions: NSRegularExpression.MatchingOptions = []
    ) throws -> String {
        let regex = try NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: string, options: matchingOptions, range: NSMakeRange(0, string.count), withTemplate: template)
    }
}

/// Represents the matches.
public struct Match {
    /// The string.
    public private(set) var string: String
    /// The `NSTextCheckingResult` object.
    public private(set) var checkResult: NSTextCheckingResult

    fileprivate init(_ checkResult: NSTextCheckingResult, _ string: String) {
        self.checkResult = checkResult
        self.string = string
    }

    /// The position of the matching range.
    public var position: Int {
        return checkResult.range.location
    }

    /// The end position of the matching range,
    public var endPosition: Int {
        return checkResult.range.location + checkResult.range.length
    }

    /// The match groups.
    /// - Returns: An array of string.
    public func groups() -> [String] {
        let ranges = self.checkResult.numberOfRanges
        return (0..<ranges).map { index in
            let range = self.checkResult.range(at: index)
            return self.string.substring(with: range.location..<(range.location + range.length)) ?? ""
        }
    }

    /// Returns the string at the given index.
    /// - Parameter index: The index.
    /// - Returns: The string.
    public func group(at index: Int) -> String? {
        if index >= self.checkResult.numberOfRanges {
            return nil
        }
        let range = self.checkResult.range(at: index)
        return self.string.substring(with: range.location..<(range.location + range.length))
    }
}
