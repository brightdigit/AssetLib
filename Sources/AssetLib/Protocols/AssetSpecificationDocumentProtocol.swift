import Foundation

/// An asset specification document for an app icon or image set.
public protocol AssetSpecificationDocumentProtocol: Codable {
  /// Metadata for the author and format version of the asset catalog.
  var info: AssetSpecificationMetadataProtocol { get }

  /***
   Properties associated with the app icon or image set.
   */
  var properties: AssetSpecificationPropertiesProtocol? { get }
  /// An array of sizes or variants of an image or icon.
  var images: [AssetSpecificationProtocol]? { get }
}
