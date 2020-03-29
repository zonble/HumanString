import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	return [
		testCase(HumanStringTests.allTests),
		testCase(RegexTests.allTests),
		testCase(StringIndexExtensionsTests.allTests),
	]
}
#endif
