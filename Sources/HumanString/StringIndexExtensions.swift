import Foundation

public extension String.Index {
	/// Makes a new String.Index object by setting an offset on the
	/// index on the left hand side.
	static func + (left: String.Index, right: (String, Int) ) -> String.Index {
		return right.0.index(left, offsetBy: right.1)
	}

	/// Makes a new String.Index object by setting an offset on the
	/// index on the left hand side.
	static func - (left: String.Index, right: (String, Int) ) -> String.Index {
		return right.0.index(left, offsetBy: -1 * right.1)
	}
}

