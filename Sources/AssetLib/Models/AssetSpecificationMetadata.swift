import Foundation
/// Metadata for the author and format version of the asset catalog.
public struct AssetSpecificationMetadata: AssetSpecificationMetadataProtocol {
  /// The default application that authored the asset catalog which is "xcode".
  public static let xcodeAuthor = "xcode"
  /// The default format version of the asset catalog which is 1.
  public static let defaultVersion = 1

  /// The application that authored the asset catalog. Use your bundle ID.
  public let author: String

  /// The format version of the asset catalog. Use 1.
  public let version: Int

  init(author: String = xcodeAuthor, version: Int = defaultVersion) {
    self.author = author
    self.version = version
  }
}

extension AssetSpecificationMetadata {
  init(_ metadata: AssetSpecificationMetadataProtocol) {
    author = metadata.author
    version = metadata.version
  }
}
