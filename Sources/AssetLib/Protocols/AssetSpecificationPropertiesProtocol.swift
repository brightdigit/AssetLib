import Foundation

public protocol AssetSpecificationPropertiesProtocol: Codable {
  var templateRenderingIntent: RenderingIntent? { get }
  // swiftlint:disable line_length
  /*
    In watchOS 5 and later, allows for calable PDF assets.
   https://developer.apple.com/documentation/watchkit/storyboard_elements/building_watchos_app_interfaces_using_the_storyboard/supporting_multiple_watch_sizes
   */
  var autoScaling: AppleWatchAutoScaingMethod? { get }
  // swiftlint:enable line_length
  /**
   The type of compression
   */
  var compressionType: CompressionType { get }
  var preservesVectorRepresentation: Bool { get }
  var localizable: Bool { get }
  var onDemandResourceTags: [String] { get }
  var preRendered: Bool { get }
}
