import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(HumanStringTests.allTests),
		testCase(RegexTests.allTests),
	]
}
#endif
