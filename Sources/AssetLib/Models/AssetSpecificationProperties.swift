import Foundation

public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol {
  public let templateRenderingIntent: RenderingIntent?
  public let autoScaling: AppleWatchAutoScaingMethod?
  public let compressionType: CompressionType?
  public let preservesVectorRepresentation: Bool?
  public let localizable: Bool?
  public let onDemandResourceTags : [String]

  public enum CodingKeys: String, CodingKey {
    case templateRenderingIntent = "template-rendering-intent"
    case autoScaling = "auto-scaling"
    case compressionType = "compression-type"
    case preservesVectorRepresentation = "preserves-vector-representation"
    case localizable
    case onDemandResourceTags = "on-demand-resource-tags"
  }

  public init(
    templateRenderingIntent: RenderingIntent?,
    autoScaling: AppleWatchAutoScaingMethod?,
    compressionType: CompressionType?,
    preservesVectorRepresentation: Bool?,
    localizable: Bool?,
    onDemandResourceTags : [String]
  ) {
    self.templateRenderingIntent = templateRenderingIntent
    self.autoScaling = autoScaling
    self.compressionType = compressionType
    self.preservesVectorRepresentation = preservesVectorRepresentation
    self.localizable = localizable
    self.onDemandResourceTags = onDemandResourceTags
  }

  public init(properties: AssetSpecificationPropertiesProtocol) {
    templateRenderingIntent = properties.templateRenderingIntent
    autoScaling = properties.autoScaling
    compressionType = properties.compressionType
    preservesVectorRepresentation = properties.preservesVectorRepresentation
    localizable = properties.localizable
    onDemandResourceTags = properties.onDemandResourceTags
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    templateRenderingIntent = try container.decodeIfPresent(RenderingIntent.self, forKey: .templateRenderingIntent)
    autoScaling = try container.decodeIfPresent(AppleWatchAutoScaingMethod.self, forKey: .autoScaling)
    compressionType = try container.decodeIfPresent(CompressionType.self, forKey: .compressionType)
    preservesVectorRepresentation = try container.decodeIfPresent(Bool.self, forKey: .preservesVectorRepresentation)
    localizable = try container.decodeIfPresent(Bool.self, forKey: .localizable)
    onDemandResourceTags = try container.decodeIfPresent([String].self, forKey: .onDemandResourceTags) ?? [String]()
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(templateRenderingIntent, forKey: .templateRenderingIntent)
    try container.encodeIfPresent(autoScaling, forKey: .autoScaling)
    if compressionType != .automatic {
    try container.encodeIfPresent(compressionType, forKey: .compressionType)
    }
    if preservesVectorRepresentation == true {
    try container.encodeIfPresent(preservesVectorRepresentation, forKey: .preservesVectorRepresentation)
    }
    if localizable == true {
      try container.encodeIfPresent(localizable, forKey: .localizable)
    }
    if onDemandResourceTags.count > 0 {
      try container.encode(self.onDemandResourceTags, forKey: .onDemandResourceTags)
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
