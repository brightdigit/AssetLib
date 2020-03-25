import AssetLib
import XCTest

final class IdiomScaleProviderTests: XCTestCase {
  func testDictionary() {
    var dictionary = [ImageIdiom: [Float]]()

    dictionary[.universal] = (0 ... 3).map { _ in Float.random(in: 0 ... 10) }
    dictionary[.car] = (0 ... 3).map { _ in Float.random(in: 0 ... 10) }
    dictionary[.mac] = (0 ... 3).map { _ in Float.random(in: 0 ... 10) }
    let scaleListProvider = IdiomScaleProvider(dictionary: dictionary)
    XCTAssertEqual(scaleListProvider.scales(forIdiom: .universal), dictionary[.universal])
    XCTAssertEqual(scaleListProvider.scales(forIdiom: .car), dictionary[.car])
    XCTAssertEqual(scaleListProvider.scales(forIdiom: .mac), dictionary[.mac])
    XCTAssertEqual(scaleListProvider.scales(forIdiom: .iphone).count, 0)
  }
}
