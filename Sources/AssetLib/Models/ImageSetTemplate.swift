import Foundation

public struct ImageSetTemplate: Codable, Equatable {
  /**
   Specifies if the image is a template for use with visual effects such as replacing colors.
    For `nil` values, if the name of the image ends in "Template", use the image as a template,
   otherwise render it as the original image.
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
    If no `LanguageDirection` is specified then
   the image has a fixed horizontal orientation and will display in the same direction.
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

  enum CodingKeys: String, CodingKey {
    case templateRenderingIntent = "template-rendering-intent"
    case compressionType = "compression-type"
    case preservesVectorRepresentation = "preserves-vector-representation"
    case devices
    case appearances
    case scaling
    case displayGamuts = "display-gamuts"
    case languageDirections = "language-directions"
    case widthClass = "width-class"
    case heightClass = "height-class"
    case memorySet = "memory-set"
    case graphicsFeatureSets = "graphics-feature-sets"
    case appleWatchScreens = "apple-watch-screens"
    case autoScaling = "auto-scaling"
    case locales
    case onDemandResourceTags = "on-demand-resource-tags"
  }

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

  // swiftlint:disable:next function_body_length
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    templateRenderingIntent = try container.decodeIfPresent(RenderingIntent.self, forKey: .templateRenderingIntent)
    compressionType = try container.decodeIfPresent(CompressionType.self, forKey: .compressionType) ?? .automatic
    preservesVectorRepresentation = try container.decodeIfPresent(
      Bool.self,
      forKey: .preservesVectorRepresentation
    ) ?? false
    devices = try container.decodeIfPresent(Set<ImageSetDevice>.self, forKey: .devices) ?? Set([.universal])
    appearances = try container.decodeIfPresent(Set<AnyAppearance>.self, forKey: .appearances) ?? Set<AnyAppearance>()
    scaling = try container.decodeIfPresent(TemplateScaling.self, forKey: .scaling)
    displayGamuts = try container.decodeIfPresent(Bool.self, forKey: .displayGamuts) ?? false
    languageDirections = try container.decodeIfPresent(
      Set<LanguageDirection>.self,
      forKey: .languageDirections
    ) ?? Set<LanguageDirection>()
    widthClass = try container.decodeIfPresent(SizeClass.self, forKey: .widthClass)
    heightClass = try container.decodeIfPresent(SizeClass.self, forKey: .heightClass)
    memorySet = try container.decodeIfPresent(Set<Memory>.self, forKey: .memorySet) ?? Set<Memory>()
    graphicsFeatureSets = try container.decodeIfPresent(
      Set<GraphicsFeatureSet>.self, forKey: .graphicsFeatureSets
    ) ?? Set<GraphicsFeatureSet>()
    appleWatchScreens = try container.decodeIfPresent(Bool.self, forKey: .appleWatchScreens) ?? false
    autoScaling = try container.decodeIfPresent(
      Bool.self,
      forKey: .autoScaling
    ) ?? false
    locales = try (
      container.decodeIfPresent([String].self,
                                forKey: .locales)?.map(
        Locale.init(identifier:))
    ).map(Set.init) ?? Set<Locale>()
    onDemandResourceTags = try container.decodeIfPresent(
      Set<String>.self,
      forKey: .onDemandResourceTags
    ) ?? Set<String>()
  }
}
