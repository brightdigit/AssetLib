import Foundation

public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol {
  public let templateRenderingIntent: RenderingIntent?
  public let autoScaling: AppleWatchAutoScaingMethod?
  public let compressionType: CompressionType?
  public let preservesVectorRepresentation: Bool?
  public let localizable: Bool?

  public enum CodingKeys: String, CodingKey {
    case templateRenderingIntent = "template-rendering-intent"
    case autoScaling = "auto-scaling"
    case compressionType = "compression-type"
    case preservesVectorRepresentation = "preserves-vector-representation"
    case localizable
  }

  public init(
    templateRenderingIntent: RenderingIntent?,
    autoScaling: AppleWatchAutoScaingMethod?,
    compressionType: CompressionType?,
    preservesVectorRepresentation: Bool?,
    localizable: Bool?
  ) {
    self.templateRenderingIntent = templateRenderingIntent
    self.autoScaling = autoScaling
    self.compressionType = compressionType
    self.preservesVectorRepresentation = preservesVectorRepresentation
    self.localizable = localizable
  }

  public init(properties: AssetSpecificationPropertiesProtocol) {
    templateRenderingIntent = properties.templateRenderingIntent
    autoScaling = properties.autoScaling
    compressionType = properties.compressionType
    preservesVectorRepresentation = properties.preservesVectorRepresentation
    localizable = properties.localizable
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    templateRenderingIntent = try container.decodeIfPresent(RenderingIntent.self, forKey: .templateRenderingIntent)
    autoScaling = try container.decodeIfPresent(AppleWatchAutoScaingMethod.self, forKey: .autoScaling)
    compressionType = try container.decodeIfPresent(CompressionType.self, forKey: .compressionType)
    preservesVectorRepresentation = try container.decodeIfPresent(Bool.self, forKey: .preservesVectorRepresentation)
    localizable = try container.decodeIfPresent(Bool.self, forKey: .localizable)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(templateRenderingIntent, forKey: .templateRenderingIntent)
    try container.encodeIfPresent(autoScaling, forKey: .autoScaling)
    try container.encodeIfPresent(compressionType, forKey: .compressionType)
    try container.encodeIfPresent(preservesVectorRepresentation, forKey: .preservesVectorRepresentation)
    if localizable == true {
      try container.encodeIfPresent(localizable, forKey: .localizable)
    }
//
//    if let images = self.images {
//      try container.encode(images.map(AssetSpecification.init(specifications:)), forKey: .images)
//    }
//
//    if let properties = self.properties {
//      try container.encode(AssetSpecificationProperties(properties: properties), forKey: .properties)
//    }
//    try container.encode(AssetSpecificationMetadata(info), forKey: .info)
  }
}
