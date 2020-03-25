import Foundation

public struct ImageSetTemplate: Codable {
  /**
   Specifies if the image is a template for use with visual effects such as replacing colors.
    For `nil` values, if the name of the image ends in "Template", use the image as a template, otherwise render it as the original image.
   */
  public let renderAs: RenderingIntent?
  /**
   The type of compression
   */
  public let compression: CompressionType
  /***
   Whether to preserve the vector information for a PDF file.
   */
  public let preserveVectorData: Bool
  /// The devices supported for the image set.
  public let devices: Set<ImageSetDevice>
  /// Specific appearances supported by the image set.
  public let appearances: Set<AnyAppearance>
  /**
   Specific scaling supported by the ImageSet. `nil` value means both are supported.
   */
  public let scaling: TemplateScaling?
  /**
   Whether to support specific display gamuts.
   */
  public let specifyGamut: Bool
  /**
   Specific horizontal display directions for the image set.
    If only one `LanguageDirection` is specified then the image is mirrored for the other `LanguageDirection`.
    If no `LanguageDirection` is specified then the image has a fixed horizontal orientation and will display in the same direction.
   */
  public let direction: Set<LanguageDirection>

  /**
   The size class for the image width.
   */
  public let specifiedWidthClass: SizeClass?

  /**
   The size class for the image height.
   */
  public let specifiedHeightClass: SizeClass?

  /**
   Specific memory configurations required by the data item.
   */
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

  /**
   Locales supported by the asset.
   */
  public let locales: [Locale]
  /***
   The on-demand resource tags for the image set.
   **/
  public let resourceTags: Set<String>
}
