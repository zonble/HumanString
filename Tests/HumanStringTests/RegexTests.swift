import XCTest
@testable import HumanString

final class RegexTests: XCTestCase {

	func testRegex() {
		let str = "Hello, playground"
		let pattern = "l(.*?)p"
		do {
			let matches = try Regex.findAll(pattern: pattern, string: str)
			XCTAssert(matches.count == 1)
			let match = matches[0]
			XCTAssert(match.group(at: 0) == "llo, p", "\(String(describing: match.group(at: 0)))")
			XCTAssert(match.group(at: 1) == "lo, ", "\(String(describing: match.group(at: 1)))")
			XCTAssert(match.groups() == ["llo, p", "lo, "])
		} catch {
			XCTFail()
		}
	}

	static var allTests = [
        ("testRegex", testRegex),
		]
}

