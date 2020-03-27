import AssetLib
import XCTest

final class SizesTests: XCTestCase {
  func testSizeSizes() {
    for type in Sizes.allCases {
      let size = Size(type)
      XCTAssertEqual(size.width, size.height)
      XCTAssertEqual(type.rawValue, size.height)
      XCTAssertEqual(size.width, type.rawValue)
    }
  }

  func testSizeSquare() {
    let length = Float.random(in: 10.0 ... 2000.0)
    let square = Size(squareWithLength: length)
    XCTAssertEqual(square.width, square.height)
    XCTAssertEqual(length, square.height)
    XCTAssertEqual(square.width, length)
  }
}
