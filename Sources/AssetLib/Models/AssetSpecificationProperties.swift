import Foundation

public struct AssetSpecificationProperties: AssetSpecificationPropertiesProtocol, Codable {
  public let templateRenderingIntent: RenderingIntent?
  public let autoScaling: AppleWatchAutoScaingMethod?
  public let compressionType: CompressionType?
  public let preservesVectorRepresentation: Bool?
  public let localizable: Bool?

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

}
