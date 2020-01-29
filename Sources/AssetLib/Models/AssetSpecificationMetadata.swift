import Foundation

public struct AssetSpecificationMetadata: AssetSpecificationMetadataProtocol {
  public let author: String
  public let version: Int

  init(author: String, version: Int = 1) {
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
