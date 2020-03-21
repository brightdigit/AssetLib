/**
 Builds a `AssetSpecificationDocument` based on the `ImageSetTemplate`
 */
struct ImageSetTemplateBuilder: AssetTemplateBuilder {
  let scaleProvider: IdiomScaleProviderProtocol
  let dependencyProvider: ISDeviceIdiomProviderProtocol

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
    let idioms = devices.compactMap(dependencyProvider.idioms(forDevice:))

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
  func document(fromTemplate configuration: ImageSetTemplate) -> AssetSpecificationDocumentProtocol {
    var specs: [AssetSpecificationProtocol] = specsBasedOn(devices: [ImageSetDevice](configuration.devices), andScaling: configuration.scaling)

    let appearances = [String: [AnyAppearance]].init(grouping: [AnyAppearance](configuration.appearances)) {
      $0.appearance
    }

    for (_, values) in appearances {
      specs.append(contentsOf: specs.flatMap { spec in
        values.map { appearance in
          var newSpec = AssetSpecificationBuilder(specifications: spec)

          newSpec.appearances.append(appearance)

          return newSpec.assetSpec()
        }
          })
    }
    if configuration.specifyGamut {
      specs = setProducts(DisplayGamut.allCases, specs: specs, withKeyPath: \.displayGamut)
    }

    if configuration.direction.count > 0 {
      specs = setProducts([LanguageDirection](configuration.direction), specs: specs, withKeyPath: \.languageDirection)
    }

    if let heightClass = configuration.specifiedHeightClass {
      specs.append(contentsOf: product(specs.filter { $0.idiom == .universal }, [heightClass], using: modifySpec(\.heightClass)))
    }

    if let widthClass = configuration.specifiedWidthClass {
      specs.append(contentsOf: product(specs.filter { $0.idiom == .universal }, [widthClass], using: modifySpec(\.widthClass)))
    }

    let tempSpecs = specs

    if configuration.memorySet.count > 0 {
      specs.append(contentsOf: product(tempSpecs.filter { $0.idiom == .universal }, [Memory](configuration.memorySet), using: modifySpec(\.memory)))
    }

    if configuration.graphicFSSet.count > 0 {
      specs.append(
        contentsOf: product(tempSpecs.filter { $0.idiom != .universal },
                            [GraphicsFeatureSet](configuration.graphicFSSet),
                            using: modifySpec(\.graphicsFeatureSet))
      )
    }

    if configuration.specifyAWWidth {
      specs = specs.flatMap { (spec) -> [AssetSpecificationProtocol] in
        guard spec.idiom == .watch else {
          return [spec]
        }
        return AppleWatchScreenWidth.allCases.map { width in
          var builder = AssetSpecificationBuilder(specifications: spec)
          builder.screenWidth = width
          return builder.assetSpec()
        }
      }
    }

    specs.append(contentsOf: product(specs, configuration.locales, using: modifySpec(\.locale)))

    let properties = AssetSpecificationProperties(
      templateRenderingIntent: configuration.renderAs,
      autoScaling: configuration.autoScaling ? .automatic : nil,
      compressionType: configuration.compression,
      preservesVectorRepresentation: configuration.preserveVectorData,
      localizable: configuration.locales.count > 0,
      onDemandResourceTags: [String](configuration.resourceTags)
    )

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: properties)
  }
}
