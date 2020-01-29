import Foundation

/// An asset specification document for an app icon or image set.
public struct AssetSpecificationDocument: AssetSpecificationDocumentProtocol, Codable {
  /// Metadata for the author and format version of the asset catalog.
  public let info: AssetSpecificationMetadataProtocol
  /// An array of sizes or variants of an image or icon.
  public let images: [AssetSpecificationProtocol]?

  enum CodingKeys: String, CodingKey {
    case images
    case info
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let info = try container.decode(AssetSpecificationMetadata.self, forKey: .info)
    let images = try container.decodeIfPresent([AssetSpecification].self, forKey: CodingKeys.images)
    self.images = images
    self.info = info
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    if let images = self.images {
      try container.encode(images.map(AssetSpecification.init(specifications:)), forKey: .images)
    }
    try container.encode(AssetSpecificationMetadata(info), forKey: .info)
  }
}
