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

func assertApproximateEquals(_ actualDocument: AssetSpecificationDocument, _ imageSetName: String) {
  let jsonDecoder = JSONDecoder()
  let hereUrl = URL(fileURLWithPath: #file)
  let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Data/Data")

  let imageSetURL = dataDirectoryUrl.appendingPathComponent(imageSetName).appendingPathComponent("Contents.json")
  let jsonEncoder = JSONEncoder()
  jsonEncoder.outputFormatting = .prettyPrinted
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

  guard let actualString = String(bytes: actualData, encoding: .utf8) else {
    XCTFail("No String")
    return
  }

  guard let expectedString = String(bytes: expectedData, encoding: .utf8) else {
    XCTFail("No String")
    return
  }

  XCTAssertEqual(expectedDocument.images?.count, actualDocument.images?.count)

  XCTAssertEqual(expectedDocument.properties?.templateRenderingIntent, actualDocument.properties?.templateRenderingIntent)
  XCTAssertEqual(expectedDocument.properties?.autoScaling, actualDocument.properties?.autoScaling)
  XCTAssertEqual(expectedDocument.properties?.compressionType, actualDocument.properties?.compressionType)
  XCTAssertEqual(expectedDocument.properties?.preservesVectorRepresentation, actualDocument.properties?.preservesVectorRepresentation)
  XCTAssertEqual(expectedDocument.properties?.localizable, actualDocument.properties?.localizable)

  try? actualString.write(
    to: hereUrl.deletingLastPathComponent().appendingPathComponent("../../../unmatched.actual.json"),
    atomically: false, encoding: .utf8
  )

  try? expectedString.write(
    to: hereUrl.deletingLastPathComponent().appendingPathComponent("../../../unmatched.expected.json"),
    atomically: false, encoding: .utf8
  )
}

final class ImageSetTemplateBuilderTests: XCTestCase {
  fileprivate func assertImageSet(_ imageSetName: String, _ template: ImageSetTemplate) {
    let builder = ImageSetTemplateBuilder()
    guard let actualDocument = builder.document(fromTemplate: template) as? AssetSpecificationDocument else {
      XCTFail("Not Actual Document")
      return
    }

    assertApproximateEquals(actualDocument, imageSetName)
  }

  func testTemplateBuilding() {
    assertImageSet("SingleImage.imageset", ImageSetTemplate(
      renderAs: .template,
      compression: .gpuOptimizedBest,
      preserveVectorData: true,
      devices: Set([.universal]),
      appearances: [ValueAppearance(value: Luminosity.light).eraseToAny(), ValueAppearance(value: Luminosity.dark).eraseToAny()],
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
    ))
    assertImageSet("ImageSet02.imageset", ImageSetTemplate(
      renderAs: nil,
      compression: .automatic,
      preserveVectorData: false,
      devices: Set([.watch, .universal]),
      appearances: [],
      scaling: nil,
      specifyGamut: false,
      direction: [.leftToRight, .rightToLeft],
      specifiedWidthClass: .regular,
      specifiedHeightClass: .compact,
      memorySet: [.requires1GB],
      graphicFSSet: [.apple6],
      specifyAWWidth: true,
      autoScaling: true,
      locales: [],
      resourceTags: ["taga", "tagb"]
    ))
    assertImageSet("Localized.imageset", ImageSetTemplate(
      renderAs: nil,
      compression: .automatic,
      preserveVectorData: false,
      devices: Set([.universal]),
      appearances: [],
      scaling: .single,
      specifyGamut: false,
      direction: [],
      specifiedWidthClass: nil,
      specifiedHeightClass: nil,
      memorySet: [],
      graphicFSSet: [],
      specifyAWWidth: false,
      autoScaling: false,
      locales: ["es-419", "en", "fr"].map(Locale.init(identifier:)),
      resourceTags: []
    ))
  }
}
