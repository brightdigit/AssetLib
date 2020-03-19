import Foundation

public protocol AssetSpecificationPropertiesProtocol: Codable {
  var templateRenderingIntent: RenderingIntent? { get }
  var autoScaling: AppleWatchAutoScaingMethod? { get }
  var compressionType: CompressionType? { get }
  var preservesVectorRepresentation: Bool? { get }
  var localizable: Bool? { get }
  var onDemandResourceTags: [String] { get }
}
