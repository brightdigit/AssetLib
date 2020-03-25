import Foundation

struct AssetSpecificationBuilder: AssetSpecificationProtocol {
  /**
   A different version of an image for each Apple Watch screen size.
   */
  public var screenWidth: AppleWatchScreenWidth?

  public var heightClass: SizeClass?

  public var widthClass: SizeClass?

  public var memory: Memory?
  /**
   The graphics feature set required for the item.
   */
  public var graphicsFeatureSet: GraphicsFeatureSet?

  public var locale: Locale?

  public var languageDirection: LanguageDirection?

  /** The color gamut of the device display for the image. */
  public var displayGamut: DisplayGamut?

  /// The device type for the image.
  public var idiom: ImageIdiom
  /// The targeted display scale for the image or icon.
  public var scale: Float?
  /// The size of the app icon.
  public var size: Size?
  /// The HEIF, .png, .jpg, or .pdf file for the image.
  public var filename: String?
  /// The role for an Apple Watch icon
  public var role: AppleWatchRole?
  /// The type of Apple Watch when there is more than one icon size for a role.
  public var subtype: DeviceSubType?

  public var appearances: [AnyAppearance]
  init(specifications: AssetSpecificationProtocol) {
    idiom = specifications.idiom
    scale = specifications.scale
    size = specifications.size
    filename = specifications.filename
    subtype = specifications.subtype
    role = specifications.role
    appearances = specifications.appearances
    screenWidth = specifications.screenWidth
    heightClass = specifications.heightClass
    widthClass = specifications.widthClass
    memory = specifications.memory
    graphicsFeatureSet = specifications.graphicsFeatureSet
    locale = specifications.locale
  }

  func assetSpec() -> AssetSpecificationProtocol {
    return AssetSpecification(specifications: self)
  }
}
