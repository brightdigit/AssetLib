import Foundation

public struct ImageSetTemplate: Codable {
  public let renderAs: RenderingIntent?
  /**
   The type of compression
   */
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
  /**
   Graphics feature sets specifically required by the Image Set.
   */
  public let graphicFSSet: Set<GraphicsFeatureSet>
  /**
   Whether to allow specific images based on Apple Watch size.
   */
  public let specifyAWWidth: Bool
  /**
   Whether to allow for auto-scaling of PDFs for the Apple Watch.
   */
  public let autoScaling: Bool
  public let locales: [Locale]
  public let resourceTags: Set<String>
}
