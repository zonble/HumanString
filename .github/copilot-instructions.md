# HumanString
HumanString is a Swift Package Manager library that provides human-friendly string indexing. Instead of using complex String.Index types, it allows using integers for string subscripting, supporting both positive indices (from start) and negative indices (from end).

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively
- Bootstrap and build the repository:
  - `swift --version` -- verify Swift 5.0+ is available (currently Swift 6.1.2)
  - `swift build` -- takes ~5 seconds. NEVER CANCEL. Set timeout to 60+ seconds.
  - Clean and rebuild: `swift package clean && swift build`
- Run tests:
  - `swift test` -- takes ~3 seconds. NEVER CANCEL. Set timeout to 60+ seconds.
  - `swift test --enable-code-coverage` -- runs tests with coverage, takes ~4 seconds
- Build warnings are normal:
  - Swift 6 compatibility warnings about `private (set)` spacing in Regex.swift are expected
  - These warnings do not affect functionality

## Validation
- Always test functionality manually after making changes to string subscripting logic
- Examine existing test cases in `Tests/HumanStringTests/HumanStringTests.swift` for validation examples:
  ```swift
  let str = "Hello, Swift!"
  // These operations should work after importing @testable HumanString:
  // str[0] == 'H'
  // str[-1] == '!'  
  // str[0..<5] == "Hello"
  // str[(-5)...] == "wift!" (note parentheses for negative ranges)
  ```
- ALWAYS run `swift test` after code changes to ensure all 10 tests pass
- ALWAYS run `swift test --enable-code-coverage` for comprehensive validation
- Test as dependency: Create a test package that imports HumanString and builds successfully

## Common Tasks
The following are outputs from frequently run commands. Reference them instead of running bash commands unnecessarily.

### Repository Structure
```
/home/runner/work/HumanString/HumanString/
├── .github/workflows/        # CI/CD workflows
│   ├── ci.yml               # Build and test on macOS
│   └── publish.yml          # Documentation publishing
├── Sources/HumanString/     # Main library code
│   ├── HumanString.swift    # Core string subscripting extensions
│   ├── Regex.swift          # Regular expression helpers
│   └── StringIndexExtensions.swift # String.Index operator overloads
├── Tests/HumanStringTests/  # Test suite
│   ├── HumanStringTests.swift
│   ├── RegexTests.swift
│   └── StringIndexExtensionsTests.swift
├── Package.swift            # Swift Package Manager manifest
├── HumanString.podspec      # CocoaPods specification
└── README.md               # Usage examples and documentation
```

### Package.swift
```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "HumanString",
    products: [
        .library(name: "HumanString", targets: ["HumanString"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "HumanString", dependencies: []),
        .testTarget(name: "HumanStringTests", dependencies: ["HumanString"]),
    ]
)
```

### CI/CD Information
- GitHub Actions run on macOS-latest
- CI builds for iOS simulator target with specific SDK flags
- Test coverage is generated using maxep/spm-lcov-action
- Documentation is published using Jazzy on releases
- No linting tools are configured in the repository

## Key Implementation Details
- **HumanString.swift**: Main functionality for integer-based string subscripting
  - Supports positive indices: `str[0]`, `str[1..<3]`
  - Supports negative indices: `str[-1]`, `str[(-3)...]`
  - Mixed positive/negative ranges return nil for safety
- **Regex.swift**: Helper utilities for regular expressions with NSRegularExpression
- **StringIndexExtensions.swift**: Operator overloads for String.Index arithmetic

## Dependencies and Installation
- No external dependencies required
- Swift 5.0+ required (supports Swift 4.2, 5.0-5.5 per podspec)
- Can be installed via Swift Package Manager or CocoaPods
- Supports iOS 8.0+, macOS 10.10+, watchOS 2.0+, tvOS 9.0+

## Development Notes
- Always use parentheses around negative numbers in range expressions: `str[(-3)...]`
- Mixed positive/negative range bounds intentionally return nil
- The library includes comprehensive test coverage for edge cases
- String.Index extensions allow arithmetic: `startIndex + (string, 4)`

## Troubleshooting
- If build fails, ensure Swift 5.0+ is available
- Warnings about Swift 6 compatibility are expected and safe to ignore
- For integration issues, verify the target imports HumanString correctly
- Negative range syntax requires parentheses to avoid parser conflicts

## Testing Scenarios
After making changes, always validate:
1. Basic subscripting: `str[0]`, `str[-1]` work correctly
2. Range operations: `str[0..<3]`, `str[2...]` return proper substrings
3. Edge cases: Empty strings, out-of-bounds access handled gracefully
4. Integration: Library builds successfully as a dependency
5. Performance: String operations maintain expected performance characteristics