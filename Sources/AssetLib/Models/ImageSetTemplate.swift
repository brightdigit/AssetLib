import Foundation

public struct ImageSetTemplate: Codable {
  /**
   Specifies if the image is a template for use with visual effects such as replacing colors.
    For `nil` values, if the name of the image ends in "Template", use the image as a template, otherwise render it as the original image.
   */
  public let templateRenderingIntent: RenderingIntent?
  /**
   The type of compression
   */
  public let compressionType: CompressionType
  /***
   Whether to preserve the vector information for a PDF file.
   */
  public let preservesVectorRepresentation: Bool
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
  public let displayGamuts: Bool
  /**
   Specific horizontal display directions for the image set.
    If only one `LanguageDirection` is specified then the image is mirrored for the other `LanguageDirection`.
    If no `LanguageDirection` is specified then the image has a fixed horizontal orientation and will display in the same direction.
   */
  public let languageDirections: Set<LanguageDirection>

  /**
   The size class for the image width.
   */
  public let widthClass: SizeClass?

  /**
   The size class for the image height.
   */
  public let heightClass: SizeClass?

  /**
   Specific memory configurations required by the data item.
   */
  public let memorySet: Set<Memory>
  /**
   Graphics feature sets specifically required by the Image Set.
   */
  public let graphicsFeatureSets: Set<GraphicsFeatureSet>
  /**
   Whether to allow specific images based on Apple Watch size.
   */
  public let appleWatchScreens: Bool
  /**
   Whether to allow for auto-scaling of PDFs for the Apple Watch.
   */
  public let autoScaling: Bool

  /**
   Locales supported by the asset.
   */
  public let locales: Set<Locale>
  /***
   The on-demand resource tags for the image set.
   **/
  public let onDemandResourceTags: Set<String>

  public init(
    templateRenderingIntent: RenderingIntent? = nil,
    compressionType: CompressionType = .automatic,
    preservesVectorRepresentation: Bool = false,
    devices: Set<ImageSetDevice> = [.universal],
    appearances: Set<AnyAppearance> = Set(),
    scaling: TemplateScaling? = nil,
    displayGamuts: Bool = false,
    languageDirections: Set<LanguageDirection> = Set(),
    widthClass: SizeClass? = nil,
    heightClass: SizeClass? = nil,
    memorySet: Set<Memory> = Set(),
    graphicsFeatureSets: Set<GraphicsFeatureSet> = Set(),
    appleWatchScreens: Bool = false,
    autoScaling: Bool = false,
    locales: Set<Locale> = Set(),
    onDemandResourceTags: Set<String> = Set()
  ) {
    self.templateRenderingIntent = templateRenderingIntent
    self.compressionType = compressionType
    self.preservesVectorRepresentation = preservesVectorRepresentation
    self.devices = devices
    self.appearances = appearances
    self.scaling = scaling
    self.displayGamuts = displayGamuts
    self.languageDirections = languageDirections
    self.widthClass = widthClass
    self.heightClass = heightClass
    self.memorySet = memorySet
    self.graphicsFeatureSets = graphicsFeatureSets
    self.appleWatchScreens = appleWatchScreens
    self.autoScaling = autoScaling
    self.locales = locales
    self.onDemandResourceTags = onDemandResourceTags
  }
}
