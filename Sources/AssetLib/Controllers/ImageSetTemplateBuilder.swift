/**
 Builds a `AssetSpecificationDocument` based on the `ImageSetTemplate`
 */
public struct ImageSetTemplateBuilder: AssetTemplateBuilder {
  public let scaleProvider: IdiomScaleProviderProtocol
  public let dependencyProvider: ISDeviceIdiomProviderProtocol

  public init() {
    scaleProvider = IdiomScaleProvider()
    dependencyProvider = ISDeviceIdiomProvider()
  }

  typealias Template = ImageSetTemplate

  fileprivate func scalesBasedOn(_ idiom: ImageIdiom, withScaling scaling: TemplateScaling?) -> [Float?] {
    if scaling == .some(.single) {
      return [nil]
    }
    var scales: [Float?] = scaleProvider.scales(forIdiom: idiom)
    if scaling == nil {
      scales.append(nil)
    }
    return scales
  }

  func specsBasedOn(devices: [ImageSetDevice], andScaling scaling: TemplateScaling?) -> [AssetSpecificationProtocol] {
    let idioms = devices.compactMap(dependencyProvider.idiom(forDevice:))

    let scales: [[Float?]] = idioms.map { scalesBasedOn($0.0, withScaling: scaling) }

    return zip(idioms, scales).flatMap { args in
      args.1.map { scale in
        AssetSpecification(idiom: args.0.0, scale: scale, subtype: args.0.1)
      }
    }
  }

  /**
   Creates `AssetSpecificationDocumentProtocol` based on the `ImageSetTemplate`.

    - Parameter template: The `ImageSetTemplate`.
    - Returns: The `AssetSpecificationDocumentProtocol`
   */
  public func document(fromTemplate configuration: ImageSetTemplate) -> AssetSpecificationDocumentProtocol {
    var specs: [AssetSpecificationProtocol] = specsBasedOn(devices: [ImageSetDevice](configuration.devices), andScaling: configuration.scaling)

    let appearances = configuration.appearances.group(by: \.appearance)

    for (_, values) in appearances {
      specs.append(contentsOf: specs.flatMap { spec in
        values.map { appearance in
          var newSpec = AssetSpecificationBuilder(specifications: spec)

          newSpec.appearances.append(appearance)

          return newSpec.assetSpec()
        }
      })
    }
    if configuration.displayGamuts {
      specs = specs.multiply(by: DisplayGamut.allCases, with: \.displayGamut)
    }

    if configuration.languageDirections.count > 0 {
      specs = specs.multiply(by: [LanguageDirection](configuration.languageDirections), with: \.languageDirection)
    }

    if let heightClass = configuration.heightClass {
      specs = specs.multiply(by: [heightClass], with: \.heightClass, where: { $0.idiom == .universal }, operation: .append)
    }

    if let widthClass = configuration.widthClass {
      specs = specs.multiply(by: [widthClass], with: \.widthClass, where: { $0.idiom == .universal }, operation: .append)
    }

    let tempSpecs = specs

    if configuration.memorySet.count > 0 {
      specs.append(contentsOf:
        tempSpecs.multiply(by: [Memory](configuration.memorySet), with: \.memory, where: { $0.idiom == .universal })
      )
    }

    if configuration.graphicsFeatureSets.count > 0 {
      specs.append(
        contentsOf:
        tempSpecs.multiply(
          by: [GraphicsFeatureSet](configuration.graphicsFeatureSets),
          with: \.graphicsFeatureSet,
          where: { $0.idiom != .universal }
        ))
    }

    if configuration.appleWatchScreens {
      specs = specs.multiply(by: AppleWatchScreenWidth.allCases, with: \.screenWidth, where: { $0.idiom == .watch }, operation: .modify)
    }

    specs = specs.multiply(by: Array(configuration.locales), with: \.locale, operation: .append)

    let properties = AssetSpecificationProperties(
      templateRenderingIntent: configuration.templateRenderingIntent,
      autoScaling: configuration.autoScaling ? .automatic : nil,
      compressionType: configuration.compressionType,
      preservesVectorRepresentation: configuration.preservesVectorRepresentation,
      localizable: configuration.locales.count > 0,
      onDemandResourceTags: [String](configuration.onDemandResourceTags)
    )

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: properties)
  }
}
