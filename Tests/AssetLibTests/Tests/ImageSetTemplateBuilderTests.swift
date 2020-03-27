import AssetLib
import XCTest

final class ImageSetTemplateBuilderTests: XCTestCase {
  fileprivate func assertImageSet(_ imageSetName: String, _ template: ImageSetTemplate) {
    let builder = ImageSetTemplateBuilder()
    guard let actualDocument = builder.document(fromTemplate: template) as? AssetSpecificationDocument else {
      XCTFail("Not Actual Document")
      return
    }

    AssetSpecificationDocument.assertApproximateEquals(actualDocument, imageSetName)
  }

  func testTemplateBuilding() {
    assertImageSet("SingleImage.imageset", ImageSetTemplate(
      templateRenderingIntent: .template,
      compressionType: .gpuOptimizedBest,
      preservesVectorRepresentation: true,
      devices: Set([.universal]),
      appearances: [ValuedAppearance(value: Luminosity.light).eraseToAny(), ValuedAppearance(value: Luminosity.dark).eraseToAny()],
      scaling: .single,
      displayGamuts: true,
      languageDirections: [],
      widthClass: nil,
      heightClass: nil,
      memorySet: [],
      graphicsFeatureSets: [],
      appleWatchScreens: false,
      autoScaling: false,
      locales: [],
      onDemandResourceTags: []
    ))
    assertImageSet("ImageSet02.imageset", ImageSetTemplate(
      templateRenderingIntent: nil,
      compressionType: .automatic,
      preservesVectorRepresentation: false,
      devices: Set([.watch, .universal]),
      appearances: [],
      scaling: nil,
      displayGamuts: false,
      languageDirections: [.leftToRight, .rightToLeft],
      widthClass: .regular,
      heightClass: .compact,
      memorySet: [.requires1GB],
      graphicsFeatureSets: [.apple6],
      appleWatchScreens: true,
      autoScaling: true,
      locales: [],
      onDemandResourceTags: ["taga", "tagb"]
    ))
    assertImageSet("Localized.imageset", ImageSetTemplate(
      templateRenderingIntent: nil,
      compressionType: .automatic,
      preservesVectorRepresentation: false,
      devices: Set([.universal]),
      appearances: [],
      scaling: .single,
      displayGamuts: false,
      languageDirections: [],
      widthClass: nil,
      heightClass: nil,
      memorySet: [],
      graphicsFeatureSets: [],
      appleWatchScreens: false,
      autoScaling: false,
      locales: Set(["es-419", "en", "fr"].map(Locale.init(identifier:))),
      onDemandResourceTags: []
    ))
  }
}
