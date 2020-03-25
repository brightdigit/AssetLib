import Foundation

/***
 Properties associated with the app icon or image set.
 */
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

  /***
   Set to true to preserve the vector information for a PDF file.
   */
  var preservesVectorRepresentation: Bool { get }
  var localizable: Bool { get }

  /***
   The on-demand resource tags for the image set.
   **/
  var onDemandResourceTags: [String] { get }
  /***
   Backward compatibility for iOS 6.0 indicating if the icon includes the mask and shine effect.
   */
  var preRendered: Bool { get }
}
