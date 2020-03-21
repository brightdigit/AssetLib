import Foundation

public struct AppIconTemplateBuilder: AssetTemplateBuilder {
  typealias Template = AppIconTemplate

  let supportsDisplayGamut: ImageIdiomDisplayGamutProtocol
  let appIconSpecifications: ImageIdiomAppIconSpecificationProvider
  let map: AppIconDeviceIdiomMapProtocol

  init(
    supportsDisplayGamut: ImageIdiomDisplayGamutProtocol? = nil,
    appIconSpecifications: ImageIdiomAppIconSpecificationProvider? = nil,
    map: AppIconDeviceIdiomMapProtocol? = nil
  ) {
    self.supportsDisplayGamut = supportsDisplayGamut ?? ImageIdiomDisplayGamut(supportedImageIdioms: [.iphone, .ipad, .mac])
    self.appIconSpecifications = appIconSpecifications ?? ImageIdiomAppIconSpecificationMap()
    self.map = map ?? AppIconDeviceIdiomMap()
  }

  public func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol {
    let specs = Set(template.devices.flatMap(map.idiom(forDevice:))).flatMap { (idiom) -> [AssetSpecificationProtocol] in
      // let specsOpt = dictionary[idiom]
      let specs = appIconSpecifications.appIcon(specificationFor: idiom)

      guard supportsDisplayGamut.supportsDisplayGamut(idiom) else {
        return specs
      }

      return setProducts(DisplayGamut.allCases, specs: specs, withKeyPath: \.displayGamut)
    }

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: AssetSpecificationProperties(preRendered: true))
  }
}
