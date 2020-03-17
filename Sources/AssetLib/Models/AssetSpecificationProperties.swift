import Foundation

public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol, Codable {
  public let templateRenderingIntent: RenderingIntent?
  public let autoScaling: AppleWatchAutoScaingMethod?
  public let compressionType: CompressionType?
  public let preservesVectorRepresentation: Bool?
  public let localizable: Bool?

  public init(properties: AssetSpecificationPropertiesProtocol) {
    templateRenderingIntent = properties.templateRenderingIntent
    autoScaling = properties.autoScaling
    compressionType = properties.compressionType
    preservesVectorRepresentation = properties.preservesVectorRepresentation
    localizable = properties.localizable
  }
}
