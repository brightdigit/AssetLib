import Foundation

public protocol AssetSpecificationPropertiesProtocol {
  var templateRenderingIntent: RenderingIntent? { get }

  var autoScaling: AppleWatchAutoScaingMethod? { get }

  var compressionType: CompressionType? { get }

  var preservesVectorRepresentation: Bool? { get }

  var localizable: Bool? { get }
}
