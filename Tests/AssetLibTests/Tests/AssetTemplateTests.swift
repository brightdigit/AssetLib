@testable import AssetLib
import XCTest

final class AssetTemplateTests: XCTestCase {
  func testTemplate() {
    let template = ImageSetTemplate(
      renderAs: .template,
      compression: .gpuOptimizedBest,
      preserveVectorData: true,
      devices: Set([.universal, .iphone, .ipad, .macCatalyst, .watch]),
      appearances: [ValueAppearance(value: Luminosity.dark).eraseToAny(), ValueAppearance(value: Luminosity.light).eraseToAny()],
      scaling: .individual,
      specifyGamut: true,
      direction: [],
      specifiedWidthClass: nil,
      specifiedHeightClass: nil,
      memorySet: [.requires1GB, .requires2GB, .requires4GB],
      graphicFSSet: [.metal3v1, .metal4v1, .apple6],
      specifyAWWidth: true,
      autoScaling: true,
      locales: [],
      resourceTags: []
    )
    
    
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/Data")
    
    let bigImageSet = dataDirectoryUrl.appendingPathComponent("BigImageSet.imageset").appendingPathComponent("Contents.json")
    
    
    

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
