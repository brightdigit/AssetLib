@testable import AssetLib
import XCTest

struct MockValueType: AppearanceValue {
  static var appearanceKey: String {
    return "mock"
  }

  let appearanceValue: String
}

final class ValueAppearanceTests: XCTestCase {
  func assertAppearanceValue<ValueType: AppearanceValue>(value: ValueType) {
    let val = ValuedAppearance(value: value)
    XCTAssertEqual(value.appearanceValue, val.value)
    XCTAssertEqual(val.appearance, ValueType.appearanceKey)
    let anyValue = val.eraseToAny()
    XCTAssertEqual(anyValue.value, value.appearanceValue)
    XCTAssertEqual(anyValue.appearance, ValueType.appearanceKey)
  }

  func testValues() {
    assertAppearanceValue(value: Contrast.high)
    assertAppearanceValue(value: Luminosity.light)
    assertAppearanceValue(value: Luminosity.dark)
    assertAppearanceValue(value: MockValueType(appearanceValue: "value"))
  }
}
