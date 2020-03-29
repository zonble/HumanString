import XCTest
@testable import HumanString

final class HumanStringTests: XCTestCase {
	func testSubstring1() {
		let str = "今天天氣好清爽"
		XCTAssertTrue(str[0] == "今")
		XCTAssertTrue(str[4] == "好")
		XCTAssertTrue(str[-1] == "爽")
		XCTAssertTrue(str[0..<2] == "今天")
		XCTAssertTrue(str[0...2] == "今天天")
		XCTAssertTrue(str[-3 ..< -1] == "好清")
		XCTAssertTrue(str[-3 ... -1] == "好清爽")
		XCTAssertTrue(str[-3 ... 0] == nil)
		XCTAssertTrue(str[-3 ..< 0] == "好清爽")
		XCTAssertTrue(str[-3 ..< 1] == nil)
		XCTAssertTrue(str[-3 ... 1] == nil)
		XCTAssertTrue(str[0...] == "今天天氣好清爽")
		XCTAssertTrue(str[1...] == "天天氣好清爽")
		XCTAssertTrue(str[(-2)...] == "清爽")
		XCTAssertTrue(str[(-1)...] == "爽")
		XCTAssertTrue(str[..<3] == "今天天")
		XCTAssertTrue(str[...3] == "今天天氣")
		XCTAssertTrue(str[..<(-1)] == "今天天氣好清")
		XCTAssertTrue(str[...(-1)] == "今天天氣好清爽")
	}

	func testSubstring2() {
		let str = "abcde"
		XCTAssertTrue(str[0] == "a")
		XCTAssertTrue(str[4] == "e")
		XCTAssertTrue(str[-1] == "e")
		XCTAssertTrue(str[0..<2] == "ab")
		XCTAssertTrue(str[0...2] == "abc")
		XCTAssertTrue(str[-3 ..< -1] == "cd")
		XCTAssertTrue(str[-3 ... -1] == "cde")
		XCTAssertTrue(str[-3 ... 0] == nil)
		XCTAssertTrue(str[-3 ..< 0] == "cde")
		XCTAssertTrue(str[-3 ..< 1] == nil)
		XCTAssertTrue(str[-3 ... 1] == nil)
	}

	func testAt() {
		let str = "abcde"
		let index1 = str.index(at: 1)
		XCTAssertTrue(str[index1] == "b")
		let index2 = str.index(at: -1)
		XCTAssertTrue(str[index2] == "e")
	}

	func testOp() {
		let str = "abcde"
		let i = str.startIndex + (str, 4)
		XCTAssertTrue(str[i] == "e")
	}

	static var allTests = [
        ("testSubstring1", testSubstring1),
        ("testSubstring2", testSubstring2),
        ("testAt", testAt),
        ("testOp", testOp),
		]
}

