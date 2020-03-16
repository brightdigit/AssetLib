@testable import AssetLib
import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

protocol ImageIdiomScaleProvider {
  func scales(forIdiom idiom: ImageIdiom) -> Set<CGFloat>
}

protocol ImageIdiomDependencyProvider {
  func idioms(forDevice device: ImageSetDevice) -> [(ImageIdiom, DeviceSubType?)]
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

    let scales = idioms.map { scaleProvider.scales(forIdiom: $0.0) }
    var specs = zip(idioms, scales).flatMap { args in
      args.1.map { scale in
        AssetSpecification(idiom: args.0.0, scale: scale, subtype: args.0.1)
      }
    }
    [String: [AnyAppearance]].init(grouping: [AnyAppearance](configuration.appearances)) {
      $0.appearance
    }

    fatalError()
  }
}
