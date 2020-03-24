import Foundation

/**
 Builds a `AssetSpecificationDocument` based on the `AppIconTemplate`
 */
public struct AppIconTemplateBuilder: AssetTemplateBuilder {
  typealias Template = AppIconTemplate

  /**
   Tells whether the `ImageIdiom` supports display gamuts.
   */
  public let supportsDisplayGamut: ImageIdiomDisplayGamutProtocol

  /**
   Returns a list of `AssetSpecificationProtocol` based on the `ImageIdiom`.
   */
  public let appIconSpecifications: IdiomAppIconSpecProvider

  /**
   Returns a list of `ImageIdiom` based on the  `AppIconDevice`.
   */
  public let idiomDeviceMap: AppIconDeviceIdiomMapProtocol

  /// Creates the `AppIconTemplateBuilder`.
  /// - Parameters:
  ///   - supportsDisplayGamut: Tells whether the `ImageIdiom` supports display gamuts.
  ///   - appIconSpecifications: Returns a list of `AssetSpecificationProtocol` based on the `ImageIdiom`.
  ///   - idiomDeviceMap: Returns a list of `ImageIdiom` based on the  `AppIconDevice`.
  public init(
    supportsDisplayGamut: ImageIdiomDisplayGamutProtocol? = nil,
    appIconSpecifications: IdiomAppIconSpecProvider? = nil,
    map: AppIconDeviceIdiomMapProtocol? = nil
  ) {
    self.supportsDisplayGamut = supportsDisplayGamut ?? ImageIdiomDisplayGamut(supportedImageIdioms: [.iphone, .ipad, .mac])
    self.appIconSpecifications = appIconSpecifications ?? IdiomAppIconSpecMap()
    idiomDeviceMap = map ?? AppIconDeviceIdiomMap()
  }

  /**
   Creates `AssetSpecificationDocumentProtocol` based on the `AppIconTemplate`.

    - Parameter template: The `AppIconTemplate`.
    - Returns: The `AssetSpecificationDocumentProtocol`
   */
  public func document(fromTemplate template: AppIconTemplate) -> AssetSpecificationDocumentProtocol {
    let specs = Set(template.devices.flatMap(idiomDeviceMap.idiom(forDevice:))).flatMap { (idiom) -> [AssetSpecificationProtocol] in
      let specs = appIconSpecifications.appIcon(specificationFor: idiom)

      guard template.specifyGamut, supportsDisplayGamut.supportsDisplayGamut(idiom) else {
        return specs
      }

      return specs.multiply(by: DisplayGamut.allCases, with: \.displayGamut)
    }

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: AssetSpecificationProperties(preRendered: template.prerendered))
  }
}
