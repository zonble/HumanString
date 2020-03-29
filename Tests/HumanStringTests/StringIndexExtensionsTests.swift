import XCTest
@testable import HumanString

final class StringIndexExtensionsTests: XCTestCase {
	func testAdd() {
		let s = "abcde"
		let index = s.startIndex + (s, 1)
		XCTAssert(s[index] == "b")
	}

	func testSubstract() {
		let s = "abcde"
		let index = s.endIndex - (s, 2)
		XCTAssert(s[index] == "d", "\(s[index])")
	}

	func testSubstract2() {
		let s = "abcde"
		let index = (s.startIndex + (s, 2)) - (s, 1)
		XCTAssert(s[index] == "b", "\(s[index])")
	}

	static var allTests = [
        ("testAdd", testAdd),
        ("testSubstract", testSubstract),
        ("testSubstract2", testSubstract2),
	]
}
