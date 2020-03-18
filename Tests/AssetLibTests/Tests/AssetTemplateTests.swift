@testable import AssetLib
import XCTest

func tryAndFail<T>(_ closure: () throws -> T) -> T? {
  var result: T?
  do {
    result = try closure()
  } catch {
    XCTFail(error.localizedDescription)
  }
  return result
}

final class AssetTemplateTests: XCTestCase {
  fileprivate func assertImageSet(_ imageSetName: String, _ template: ImageSetTemplate) {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/Data")

    let imageSetURL = dataDirectoryUrl.appendingPathComponent(imageSetName).appendingPathComponent("Contents.json")

    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let jsonDecoder = JSONDecoder()
    let builder = ImageSetTemplateBuilder()
    guard let actualDocument = builder.document(fromTemplate: template) as? AssetSpecificationDocument else {
      XCTFail("Not Actual Document")
      return
    }

    guard let actualData = tryAndFail({ try jsonEncoder.encode(actualDocument) }) else {
      return
    }

    guard let expectedDataRead = tryAndFail({ try Data(contentsOf: imageSetURL) }) else {
      return
    }

    guard let expectedDocument = tryAndFail({ try jsonDecoder.decode(AssetSpecificationDocument.self, from: expectedDataRead) }) else {
      return
    }

    guard let expectedData = tryAndFail({ try jsonEncoder.encode(expectedDocument) }) else {
      return
    }

    let mismatches = Data.jsonMismatch(lhs: actualData, rhs: expectedData)

    if mismatches.count > 0 {
      try? expectedData.write(to: hereUrl.deletingLastPathComponent().appendingPathComponent("../../../unmatched.expected.json"))

      try? actualData.write(to: hereUrl.deletingLastPathComponent().appendingPathComponent("../../../unmatched.actual.json"))
      XCTFail(mismatches.debugDescription)
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
