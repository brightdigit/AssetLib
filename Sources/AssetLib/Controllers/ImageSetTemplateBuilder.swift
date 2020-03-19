struct ImageSetTemplateBuilder: AssetTemplateBuilder {
  let scaleProvider: IdiomScaleProviderProtocol
  let dependencyProvider: ISDeviceIdiomProviderProtocol

  public init() {
    scaleProvider = IdiomScaleProvider()
    dependencyProvider = ISDeviceIdiomProvider()
  }

  typealias Template = ImageSetTemplate

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

  func document(fromTemplate configuration: ImageSetTemplate) -> AssetSpecificationDocumentProtocol {
    let idioms = configuration.devices.map(dependencyProvider.idioms(forDevice:))

    let scales: [[Float?]] = idioms.map { scalesBasedOn($0.0, withScaling: configuration.scaling) }

    var specs: [AssetSpecificationProtocol] = zip(idioms, scales).flatMap { args in
      args.1.map { scale in
        AssetSpecification(idiom: args.0.0, scale: scale, subtype: args.0.1)
      }
    }

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
      specs.append(contentsOf: product(specs.filter { $0.idiom == .universal }, [heightClass], using: { spec, sizeClass in
        var builder = AssetSpecificationBuilder(specifications: spec)
        builder.heightClass = sizeClass
        return builder.assetSpec()
      }))
    }

    if let widthClass = configuration.specifiedWidthClass {
      specs.append(contentsOf: product(specs.filter { $0.idiom == .universal }, [widthClass], using: { spec, sizeClass in
        var builder = AssetSpecificationBuilder(specifications: spec)
        builder.widthClass = sizeClass
        return builder.assetSpec()
      }))
    }

    let tempSpecs = specs

    if configuration.memorySet.count > 0 {
      specs.append(contentsOf: product(tempSpecs.filter { $0.idiom == .universal }, [Memory](configuration.memorySet)) { spec, memory in
        var builder = AssetSpecificationBuilder(specifications: spec)
        builder.memory = memory
        return builder.assetSpec()
      })
    }

    if configuration.graphicFSSet.count > 0 {
      specs.append(contentsOf: product(tempSpecs.filter { $0.idiom != .universal },
                                       [GraphicsFeatureSet](configuration.graphicFSSet)) { spec, graphicsFeatureSet in
          var builder = AssetSpecificationBuilder(specifications: spec)
          builder.graphicsFeatureSet = graphicsFeatureSet
          return builder.assetSpec()
      })
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

    specs.append(contentsOf: product(specs, configuration.locales, using: { spec, locale in
      var builder = AssetSpecificationBuilder(specifications: spec)
      builder.locale = locale
      return builder.assetSpec()
         }))

    let properties = AssetSpecificationProperties(
      templateRenderingIntent: configuration.renderAs,
      autoScaling: configuration.autoScaling ? .automatic : nil,
      compressionType: configuration.compression,
      preservesVectorRepresentation: configuration.preserveVectorData,
      localizable: configuration.locales.count > 0 ? true : nil,
      onDemandResourceTags: [String](configuration.resourceTags)
    )

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs, properties: properties)
  }
}
