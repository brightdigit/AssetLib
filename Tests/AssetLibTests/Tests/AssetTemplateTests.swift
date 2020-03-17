@testable import AssetLib
import XCTest

final class AssetTemplateTests: XCTestCase {
  func testTemplate() {
    let template = AssetTemplate(configuration: AppIconTemplateConfiguration(devices: Set<ImageIdiom>(), specifyGamut: false, prerendered: true))

    let builder = AssetTemplateBuilder()

    let document = builder.document(fromTemplate: template)
    XCTAssertNotNil(document.images)

    guard let count = document.images?.count else {
      XCTFail("Missing images")
      return
    }
    debugPrint(count)
    XCTAssertGreaterThan(count, 10)
  }
}
