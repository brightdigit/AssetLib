@testable import AssetLib
import XCTest

final class AssetTemplateTests: XCTestCase {
  func testTemplate() {
    let template = ImageSetTemplate(
      renderAs: nil,
      compression: .automatic,
      preserveVectorData: false,
      devices: Set(ImageSetDevice.allCases),
      appearances: [ValueAppearance(value: Luminosity.dark).eraseToAny()],
      scaling: nil,
      specifyGamut: true,
      direction: [.leftToRight, .rightToLeft],
      specifiedWidthClass: .regular,
      specifiedHeightClass: .compact,
      memorySet: [.requires1GB, .requires4GB],
      graphicFSSet: [.metal4v1],
      specifyAWWidth: true,
      autoScaling: true,
      locales: [Locale(identifier: "en"), Locale(identifier: "fr")],
      resourceTags: ["tag", "otherTag"]
    )

    let builder = ImageSetTemplateBuilder()

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
