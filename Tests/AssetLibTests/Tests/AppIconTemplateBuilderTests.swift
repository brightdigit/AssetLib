import AssetLib
import XCTest

final class AppIconTemplateBuilderTests: XCTestCase {
  func testTemplates() {
    let template = AppIconTemplate(
      devices: [.car, .ipad, .iphone, .mac, .tv, .watch],
      specifyGamut: true, prerendered: true
    )
    let builder = AppIconTemplateBuilder()

    guard let actualDocument = builder.document(fromTemplate: template) as? AssetSpecificationDocument else {
      XCTFail("Not Actual Document")
      return
    }

    AssetSpecificationDocument.assertApproximateEquals(
      actualDocument,
      "BigAppIcon.appiconset"
    )
  }
}
