import Foundation

/// An asset specification document for an app icon or image set.
public struct AssetSpecificationDocument: AssetSpecificationDocumentProtocol, Codable {
  /// Metadata for the author and format version of the asset catalog.
  public let info: AssetSpecificationMetadataProtocol

  /***
   Properties associated with the app icon or image set.
   */
  public let properties: AssetSpecificationPropertiesProtocol?

  /// An array of sizes or variants of an image or icon.
  public let images: [AssetSpecificationProtocol]

  enum CodingKeys: String, CodingKey {
    case images
    case info
    case properties
  }

  public init(
    info: AssetSpecificationMetadataProtocol,
    images: [AssetSpecificationProtocol],
    properties: AssetSpecificationPropertiesProtocol? = nil
  ) {
    self.info = info
    self.images = images
    self.properties = properties
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let info = try container.decode(AssetSpecificationMetadata.self, forKey: .info)
    let properties = try container.decodeIfPresent(AssetSpecificationProperties.self, forKey: .properties)
    let images = try container.decodeIfPresent(
      [AssetSpecification].self,
      forKey: CodingKeys.images
    ) ?? [AssetSpecificationProtocol]()
    self.images = images
    self.properties = properties
    self.info = info
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    if !images.isEmpty {
      try container.encode(images.map(AssetSpecification.init(specifications:)), forKey: .images)
    }

    if let properties = self.properties {
      try container.encode(AssetSpecificationProperties(properties: properties), forKey: .properties)
    }
    try container.encode(AssetSpecificationMetadata(info), forKey: .info)
  }
}
