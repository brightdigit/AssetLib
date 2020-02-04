import Foundation

#if canImport(CoreGraphics)
  import CoreGraphics
#endif

/// A size or variant of an image or icon.
public protocol AssetSpecificationProtocol {
  /// The device type for the image.
  var idiom: ImageIdiom { get }
  /// The targeted display scale for the image or icon.
  var scale: CGFloat? { get }
  /// The size of the app icon.
  var size: CGSize? { get }
  /// The HEIF, .png, .jpg, or .pdf file for the image.
  var filename: String? { get }
  /// The role for an Apple Watch icon
  var role: AppleWatchRole? { get }
  /// The type of Apple Watch when there is more than one icon size for a role.
  var subtype: AppleWatchType? { get }
}
