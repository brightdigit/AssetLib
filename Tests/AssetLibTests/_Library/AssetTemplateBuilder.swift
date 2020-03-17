@testable import AssetLib
import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

func multiply<Multiplier, Element>(
  sequence: [Element],
  by other: [Multiplier],
  andAppend shouldAppend: Bool = false,
  onlyIf test: Bool = true,
  using closure: (Element, Multiplier) -> Element
) -> [Element] {
  guard test else {
    return sequence
  }

  guard !other.isEmpty else {
    return sequence
  }

  var newSequence = other.flatMap { value in
    sequence.map { element in
      closure(element, value)
    }
  }

  if shouldAppend {
    newSequence.append(contentsOf: sequence)
  }

  return newSequence
}

protocol ImageIdiomScaleProvider {
  func scales(forIdiom idiom: ImageIdiom) -> [CGFloat]
}

public struct ScaleListProvider: ImageIdiomScaleProvider {
  let dictionary: [ImageIdiom: [CGFloat]]

  static let defaultDictionary: [ImageIdiom: [CGFloat]] = [
    .universal: [1.0, 2.0, 3.0],
    .iphone: [1.0, 2.0, 3.0],
    .ipad: [1.0, 2.0],
    .mac: [1.0, 2.0],
    .tv: [1.0, 2.0],
    .watch: [2.0],
    .car: [2.0, 3.0]
  ]

  init(dictionary: [ImageIdiom: [CGFloat]]? = nil) {
    self.dictionary = dictionary ?? Self.defaultDictionary
  }

  func scales(forIdiom idiom: ImageIdiom) -> [CGFloat] {
    return dictionary[idiom] ?? [CGFloat]()
  }
}

protocol ImageIdiomDependencyProvider {
  func idioms(forDevice device: ImageSetDevice) -> [(ImageIdiom, DeviceSubType?)]
}

struct AssetSpecificationBuilder: AssetSpecificationProtocol {
  var screenWidth: AppleWatchScreenWidth?

  var heightClass: SizeClass?

  var widthClass: SizeClass?

  var memory: Memory?

  var graphicsFeatureSet: GraphicsFeatureSet?

  var locale: Locale?

  var languageDirection: LanguageDirection?

  public var displayGamut: DisplayGamut?

  /// The device type for the image.
  public var idiom: ImageIdiom
  /// The targeted display scale for the image or icon.
  public var scale: CGFloat?
  /// The size of the app icon.
  public var size: CGSize?
  /// The HEIF, .png, .jpg, or .pdf file for the image.
  public var filename: String?
  /// The role for an Apple Watch icon
  public var role: AppleWatchRole?
  /// The type of Apple Watch when there is more than one icon size for a role.
  public var subtype: DeviceSubType?

  public var appearances: [AnyAppearance]
  init(specifications: AssetSpecificationProtocol) {
    idiom = specifications.idiom
    scale = specifications.scale
    size = specifications.size
    filename = specifications.filename
    subtype = specifications.subtype
    role = specifications.role
    appearances = specifications.appearances
    screenWidth = specifications.screenWidth
    heightClass = specifications.heightClass
    widthClass = specifications.widthClass
    memory = specifications.memory
    graphicsFeatureSet = specifications.graphicsFeatureSet
    locale = specifications.locale
  }

  func assetSpec() -> AssetSpecificationProtocol {
    return AssetSpecification(specifications: self)
  }
}

struct AssetTemplateBuilder {
  let scaleProvider: ImageIdiomScaleProvider
  let dependencyProvider: ImageIdiomDependencyProvider

  func document(fromTemplate _: AssetTemplate) -> AssetSpecificationDocumentProtocol {
    let configuration = ImageSetTemplateConfiguration(
      renderAs: nil,
      compression: .automatic,
      preserveVectorData: false,
      devices: [.mac],
      appearances: [ValueAppearance(value: Luminosity.dark).eraseToAny()],
      scaling: .single,
      specifyGamut: false,
      direction: [.leftToRight],
      specifiedWidthClass: .regular,
      specifiedHeightClass: .compact,
      memorySet: [.requires1GB, .requires4GB],
      graphicFSSet: [.metal4v1],
      specifyAWWidth: true,
      autoScaling: true,
      locales: [],
      resourceTags: ["tag", "otherTag"]
    )

    /* global renderAs, compress, preserveVectorData, autoScaling, locale */

    /* appearances, specifyGamut, direction, specified*Class, memorySet, graphicFSSet, specifyAWWidth, locale */

    let idioms = configuration.devices.flatMap(dependencyProvider.idioms(forDevice:))

//    let scales = idioms.map {
//      scaleProvider.scales(forIdiom: $0.0) }
    let scales: [[CGFloat?]] = idioms.map { (args) -> [CGFloat?] in
      if configuration.scaling == .some(.single) {
        return [nil]
      }
      var scales: [CGFloat?] = scaleProvider.scales(forIdiom: args.0)
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

    specs = multiply(sequence: specs, by: [Memory](configuration.memorySet)) { spec, memory in
      var builder = AssetSpecificationBuilder(specifications: spec)
      builder.memory = memory
      return builder.assetSpec()
    }

    specs = multiply(sequence: specs, by: [GraphicsFeatureSet](configuration.graphicFSSet)) { spec, graphicsFeatureSet in
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
