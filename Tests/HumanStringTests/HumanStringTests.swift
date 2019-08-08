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

//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct
//        // results.
//        XCTAssertEqual(HumanString().text, "Hello, World!")
//    }

    static var allTests = [
        ("testSubstring1", testSubstring1),
        ("testSubstring2", testSubstring2),
		]
}
