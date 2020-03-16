@testable import AssetLib
import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

protocol ImageIdiomScaleProvider {
  func scales(forIdiom idiom: ImageIdiom) -> [CGFloat]
}

protocol ImageIdiomDependencyProvider {
  func idioms(forDevice device: ImageSetDevice) -> [(ImageIdiom, DeviceSubType?)]
}

struct AssetSpecificationBuilder: AssetSpecificationProtocol {
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
  }

  func assetSpec() -> AssetSpecificationProtocol {
    return AssetSpecification(specifications: self)
  }
}

struct AssetTemplateBuilder {
  let scaleProvider: ImageIdiomScaleProvider!
  let dependencyProvider: ImageIdiomDependencyProvider!
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
      locale: nil,
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
      specs.append(contentsOf: specs.flatMap {
        spec in
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

    fatalError()
  }
}
