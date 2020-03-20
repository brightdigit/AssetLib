import Foundation

public struct AppIconTemplateBuilder: AssetTemplateBuilder {
  typealias Template = AppIconTemplate

  func setProducts<T>(_ lhs: [T],
                      specs: [AssetSpecificationProtocol],
                      withKeyPath keyPath: WritableKeyPath<AssetSpecificationBuilder, T>) -> [AssetSpecificationProtocol] {
    lhs.flatMap { value in
      specs.map { spec in
        var specBuilder = AssetSpecificationBuilder(specifications: spec)
        specBuilder[keyPath: keyPath] = value
        return specBuilder.assetSpec()
      }
    }
  }

  public func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol {
    let appIconTemplateData = Data(base64Encoded: _appIconTemplateBase64)!
    let jsonDecoder = JSONDecoder()
    #warning("refactor")
    // swiftlint:disable:next force_try
    let masterDocument = try! jsonDecoder.decode(AssetSpecificationDocument.self, from: appIconTemplateData)

    let map = AppIconDeviceIdiomMap()
    let images = masterDocument.images ?? [AssetSpecificationProtocol]()

    let dictionary: [ImageIdiom: [AssetSpecificationProtocol]] =
      Dictionary(grouping: images) { image in
        image.idiom
      }
    let supportsDisplayGamut: ImageIdiomDisplayGamutProtocol =
      ImageIdiomDisplayGamut(supportedImageIdioms: [.iphone, .ipad, .mac])

    let specs = Set(template.devices.flatMap(map.idiom(forDevice:))).flatMap { (idiom) -> [AssetSpecificationProtocol] in
      let specsOpt = dictionary[idiom]

      guard let specs = specsOpt else {
        return [AssetSpecificationProtocol]()
      }

      guard supportsDisplayGamut.supportsDisplayGamut(idiom) else {
        return specs
      }

      return setProducts(DisplayGamut.allCases, specs: specs, withKeyPath: \.displayGamut)
    }

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: AssetSpecificationProperties(preRendered: true))
  }
}
