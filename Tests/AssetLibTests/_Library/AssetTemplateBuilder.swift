@testable import AssetLib
import Foundation

protocol AssetTemplateBuilder {
  associatedtype Template
  func document(fromTemplate template: Template) -> AssetSpecificationDocumentProtocol
}

struct ImageSetTemplateBuilder: AssetTemplateBuilder {
  let scaleProvider: ImageIdiomScaleProvider
  let dependencyProvider: ImageIdiomDependencyProvider

  public init() {
    scaleProvider = ScaleListProvider()
    dependencyProvider = ImageSetDeviceIdiomProvider()
  }

  typealias Template = ImageSetTemplate

  func document(fromTemplate configuration: ImageSetTemplate) -> AssetSpecificationDocumentProtocol {
    /* global renderAs, compress, preserveVectorData, autoScaling, locale */

    /* appearances, specifyGamut, direction, specified*Class, memorySet, graphicFSSet, specifyAWWidth, locale */

    let idioms = configuration.devices.map(dependencyProvider.idioms(forDevice:))

    let scales: [[Float?]] = idioms.map { (args) -> [Float?] in
      if configuration.scaling == .some(.single) {
        return [nil]
      }
      var scales: [Float?] = scaleProvider.scales(forIdiom: args.0)
      if configuration.scaling == nil {
        scales.append(nil)
      }
      return scales
    }
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
      specs = DisplayGamut.allCases.flatMap { displayGamut in
        specs.map { spec in
          var specBuilder = AssetSpecificationBuilder(specifications: spec)
          specBuilder.displayGamut = displayGamut
          return specBuilder.assetSpec()
        }
      }
    }

    if configuration.direction.count > 0 {
      specs = configuration.direction.flatMap { direction in
        specs.map { spec in
          var specBuilder = AssetSpecificationBuilder(specifications: spec)
          specBuilder.languageDirection = direction
          return specBuilder.assetSpec()
        }
      }
    }

    if let heightClass = configuration.specifiedHeightClass {
      specs = multiply(sequence: specs, by: [heightClass], andAppend: true, using: { spec, sizeClass in
        var builder = AssetSpecificationBuilder(specifications: spec)
        builder.heightClass = sizeClass
        return builder.assetSpec()
          })
    }

    if let widthClass = configuration.specifiedWidthClass {
      specs = multiply(sequence: specs, by: [widthClass], andAppend: true, using: { spec, sizeClass in
        var builder = AssetSpecificationBuilder(specifications: spec)
        builder.widthClass = sizeClass
        return builder.assetSpec()
          })
    }

    specs = product(specs, [Memory](configuration.memorySet)) { spec, memory in
      var builder = AssetSpecificationBuilder(specifications: spec)
      builder.memory = memory
      return builder.assetSpec()
    }

    specs = product(specs, [GraphicsFeatureSet](configuration.graphicFSSet)) { spec, graphicsFeatureSet in
      var builder = AssetSpecificationBuilder(specifications: spec)
      builder.graphicsFeatureSet = graphicsFeatureSet
      return builder.assetSpec()
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

    specs = multiply(sequence: specs, by: configuration.locales, andAppend: true, using: { spec, locale in
      var builder = AssetSpecificationBuilder(specifications: spec)
      builder.locale = locale
      return builder.assetSpec()
        })

    return AssetSpecificationDocument(info: AssetSpecificationMetadata(), images: specs)
  }
}
