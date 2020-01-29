import Foundation

/// Metadata for the author and format version of the asset catalog.
public protocol AssetSpecificationMetadataProtocol: Codable {
  /// The application that authored the asset catalog. Use your bundle ID.
  var author: String { get }
  /// The format version of the asset catalog. Use 1.
  var version: Int { get }
}
