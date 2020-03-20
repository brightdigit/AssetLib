import Foundation

public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol {
  public let templateRenderingIntent: RenderingIntent?
  public let autoScaling: AppleWatchAutoScaingMethod?
  public let compressionType: CompressionType
  public let preservesVectorRepresentation: Bool
  public let localizable: Bool
  public let preRendered: Bool
  public let onDemandResourceTags: [String]

  public enum CodingKeys: String, CodingKey {
    case templateRenderingIntent = "template-rendering-intent"
    case autoScaling = "auto-scaling"
    case compressionType = "compression-type"
    case preservesVectorRepresentation = "preserves-vector-representation"
    case localizable
    case preRendered = "pre-rendered"
    case onDemandResourceTags = "on-demand-resource-tags"
  }

  public init(
    templateRenderingIntent: RenderingIntent?,
    autoScaling: AppleWatchAutoScaingMethod?,
    compressionType: CompressionType = .automatic,
    preservesVectorRepresentation: Bool = false,
    localizable: Bool = false,
    preRendered: Bool = false,
    onDemandResourceTags: [String]
  ) {
    self.templateRenderingIntent = templateRenderingIntent
    self.autoScaling = autoScaling
    self.compressionType = compressionType
    self.preservesVectorRepresentation = preservesVectorRepresentation
    self.localizable = localizable
    self.preRendered = preRendered
    self.onDemandResourceTags = onDemandResourceTags
  }

  public init(properties: AssetSpecificationPropertiesProtocol) {
    templateRenderingIntent = properties.templateRenderingIntent
    autoScaling = properties.autoScaling
    compressionType = properties.compressionType
    preservesVectorRepresentation = properties.preservesVectorRepresentation
    localizable = properties.localizable
    preRendered = properties.preRendered
    onDemandResourceTags = properties.onDemandResourceTags
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    templateRenderingIntent = try container.decodeIfPresent(RenderingIntent.self, forKey: .templateRenderingIntent)
    autoScaling = try container.decodeIfPresent(AppleWatchAutoScaingMethod.self, forKey: .autoScaling)
    compressionType = try container.decodeIfPresent(CompressionType.self, forKey: .compressionType) ?? .automatic
    preservesVectorRepresentation = try container.decodeIfPresent(Bool.self, forKey: .preservesVectorRepresentation) ?? false
    localizable = try container.decodeIfPresent(Bool.self, forKey: .localizable) ?? false
    preRendered = try container.decodeIfPresent(Bool.self, forKey: .preRendered) ?? false
    onDemandResourceTags = try container.decodeIfPresent([String].self, forKey: .onDemandResourceTags) ?? [String]()
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(templateRenderingIntent, forKey: .templateRenderingIntent)
    try container.encodeIfPresent(autoScaling, forKey: .autoScaling)
    if compressionType != .automatic {
      try container.encodeIfPresent(compressionType, forKey: .compressionType)
    }
    if preservesVectorRepresentation {
      try container.encode(preservesVectorRepresentation, forKey: .preservesVectorRepresentation)
    }
    if localizable {
      try container.encode(localizable, forKey: .localizable)
    }
    if preRendered {
      try container.encode(preRendered, forKey: .preRendered)
    }
    if onDemandResourceTags.count > 0 {
      try container.encode(onDemandResourceTags, forKey: .onDemandResourceTags)
    }
  }
}
