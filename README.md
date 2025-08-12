# HumanString

[![Actions Status](https://github.com/zonble/HumanString/workflows/Build/badge.svg)](https://github.com/zonble/HumanString/actions)
[![codecov](https://codecov.io/gh/zonble/HumanString/branch/master/graph/badge.svg)](https://codecov.io/gh/zonble/HumanString)

HumanString is a package that let you use integers but not String.Index to
specify ranges in strings.

``` swift
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
```

## Installation

You can install the package using Swift package manager. Add the following lines to your `Packages.swift` file:

```
dependencies: [
    .package(url: "https://github.com/zonble/HumanString.git"),
],
```

You can also install the library using CocoaPods, just add `pod "HumanString"`
to you Podfile.

## Notes

Swift adopts String.Index since Swift 4. It tends to reminder you that the width
of a string is not fixed (See[Strings in Swift 4](https://oleb.net/blog/2017/11/swift-4-strings/)).
However, it is somehow painful. For example, if you want to extract a prefix
from "Hello World", it could be:

``` swift
let str = "Hello World"
let subString = s[...str.index(str.startIndex, offsetBy: 5)]
```

But wait, somehow you are still using integers, right? The code above could be
written as:

``` swift
let subString = s[str.index(str.startIndex, offsetBy: 0)...str.index(str.startIndex, offsetBy: 5)]
```

I know the Swift team does not like what I am doing here, but somehow I still
want to make my life easier.
