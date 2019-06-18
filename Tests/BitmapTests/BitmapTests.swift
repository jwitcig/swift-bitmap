import XCTest
@testable import Bitmap

final class BitmapTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Bitmap().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
