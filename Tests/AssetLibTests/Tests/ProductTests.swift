@testable import AssetLib
import XCTest

struct TestData {
  let a: [UUID]
  let b: [UUID]
  let expected: [ResultData]
}

struct ResultData: Equatable, Comparable {
  static func < (lhs: ResultData, rhs: ResultData) -> Bool {
    return lhs.a.uuidString < rhs.a.uuidString
  }

  let a: UUID
  let b: UUID
}

final class ProductTests: XCTestCase {
  func testProduct() {
    let attemptCount = 20
    let minCount = 4
    let maxCount = 8
    let dataSet: [TestData] = (0 ..< attemptCount).map { _ in
      let aCount = Int.random(in: minCount ... maxCount)
      let bCount = Int.random(in: minCount ... maxCount)
      let a = (0 ..< aCount).map { _ in UUID() }
      let b = (0 ..< bCount).map { _ in UUID() }
      let expected = a.flatMap {
        a in
        b.map { b in
          ResultData(a: a, b: b)
        }
      }.sorted()
      return TestData(a: a, b: b, expected: expected)
    }

    for data in dataSet {
      let actual = product(data.a, data.b, using: ResultData.init).sorted()
      XCTAssertEqual(data.expected, actual)
    }
  }
}
