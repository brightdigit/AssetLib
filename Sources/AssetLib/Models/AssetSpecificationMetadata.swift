import Foundation

public struct AssetSpecificationMetadata: AssetSpecificationMetadataProtocol {
  public static let xcodeAuthor = "xcode"
  public static let defaultVersion = 1
  public let author: String
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
