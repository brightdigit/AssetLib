import Foundation

/// A size or variant of an image or icon.
public protocol AssetSpecificationProtocol {
  /// The device type for the image.
  var idiom: ImageIdiom { get }
  /// The targeted display scale for the image or icon.
  var scale: Float? { get }
  /// The size of the app icon.
  var size: Size? { get }
  /// The HEIF, .png, .jpg, or .pdf file for the image.
  var filename: String? { get }
  /// The role for an Apple Watch icon
  var role: AppleWatchRole? { get }
  /// The type of Apple Watch when there is more than one icon size for a role.
  var subtype: DeviceSubType? { get }

  var appearances: [AnyAppearance] { get }

  var displayGamut: DisplayGamut? { get }

  var languageDirection: LanguageDirection? { get }

  var screenWidth: AppleWatchScreenWidth? { get }
  var heightClass: SizeClass? { get }
  var widthClass: SizeClass? { get }
  var memory: Memory? { get }
  var graphicsFeatureSet: GraphicsFeatureSet? { get }
  var locale: Locale? { get }
}
