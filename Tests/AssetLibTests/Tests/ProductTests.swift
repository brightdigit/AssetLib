@testable import AssetLib
import XCTest

struct TestData {
  let lhs: [UUID]
  let rhs: [UUID]
  let expected: [ResultData]
}

struct ResultData: Equatable, Comparable {
  static func < (lhs: ResultData, rhs: ResultData) -> Bool {
    return lhs.lhs.uuidString < rhs.lhs.uuidString
  }

  let lhs: UUID
  let rhs: UUID
}

final class ProductTests: XCTestCase {
  func testProduct() {
    let attemptCount = 20
    let minCount = 4
    let maxCount = 8
    let dataSet: [TestData] = (0 ..< attemptCount).map { _ in
      let aCount = Int.random(in: minCount ... maxCount)
      let bCount = Int.random(in: minCount ... maxCount)
      let lhs = (0 ..< aCount).map { _ in UUID() }
      let rhs = (0 ..< bCount).map { _ in UUID() }
      let expected = lhs.flatMap {
        lhs in
        rhs.map { rhs in
          ResultData(lhs: lhs, rhs: rhs)
        }
      }.sorted()
      return TestData(lhs: lhs, rhs: rhs, expected: expected)
    }

    for data in dataSet {
      let actual = product(data.lhs, data.rhs, using: ResultData.init).sorted()
      XCTAssertEqual(data.expected, actual)
    }
  }
}
