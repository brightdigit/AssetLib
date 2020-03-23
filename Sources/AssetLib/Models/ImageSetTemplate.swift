import Foundation

public struct ImageSetTemplate: Codable {
  public let renderAs: RenderingIntent?
  public let compression: CompressionType
  public let preserveVectorData: Bool
  public let devices: Set<ImageSetDevice>
  public let appearances: Set<AnyAppearance>
  public let scaling: TemplateScaling?
  public let specifyGamut: Bool
  public let direction: Set<LanguageDirection>
  public let specifiedWidthClass: SizeClass?
  public let specifiedHeightClass: SizeClass?
  public let memorySet: Set<Memory>
  public let graphicFSSet: Set<GraphicsFeatureSet>
  public let specifyAWWidth: Bool
  public let autoScaling: Bool
  public let locales: [Locale]
  public let resourceTags: Set<String>
}
