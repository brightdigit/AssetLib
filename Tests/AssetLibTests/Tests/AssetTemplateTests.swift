@testable import AssetLib
import XCTest

final class AssetTemplateTests: XCTestCase {
  fileprivate func assertImageSet(_ imageSetName: String, _ template: ImageSetTemplate) {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/Data")

    let bigImageSetUrl = dataDirectoryUrl.appendingPathComponent(imageSetName).appendingPathComponent("Contents.json")

    let builder = ImageSetTemplateBuilder()

    let actual = builder.document(fromTemplate: template) as! AssetSpecificationDocument
    XCTAssertNotNil(actual.images)

    let expectedData = try! Data(contentsOf: bigImageSetUrl)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    let actualData = try! encoder.encode(actual)
    let decoder = JSONDecoder()
    let expected = try! decoder.decode(AssetSpecificationDocument.self, from: expectedData)

    XCTAssertEqual(expected.images?.count, actual.images?.count)
    let mismatch = Data.jsonMismatch(lhs: actualData, rhs: expectedData)
    XCTAssert(mismatch.isEmpty)

    if !mismatch.isEmpty {
      try? actualData.write(to: hereUrl.deletingLastPathComponent().appendingPathComponent("../../../unmatched.json"))
    }
  }

  func testTemplate() {
    let template = ImageSetTemplate(
      renderAs: .template,
      compression: .gpuOptimizedBest,
      preserveVectorData: true,
      devices: Set([.universal]),
      appearances: [ValueAppearance(value: Luminosity.dark).eraseToAny(), ValueAppearance(value: Luminosity.light).eraseToAny()],
      scaling: .single,
      specifyGamut: true,
      direction: [],
      specifiedWidthClass: nil,
      specifiedHeightClass: nil,
      memorySet: [],
      graphicFSSet: [],
      specifyAWWidth: false,
      autoScaling: false,
      locales: [],
      resourceTags: []
    )
    let imageSetName = "SingleImage.imageset"
    assertImageSet(imageSetName, template)
  }
}
