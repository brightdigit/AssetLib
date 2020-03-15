import Foundation

/// The device type for the image.
public enum ImageSetDevice {
  ///  The image works on any device and platform.
  case universal
  ///  The image is for iPhone devices.
  case iphone
  ///  The image is for iPad devices.
  case ipad
  ///  The image is for Mac computers.
  case mac
  // swiftlint:disable identifier_name
  ///  The image is for Apple TV.
  case tv
  // swiftlint:enable identifier_name
  ///  The image is for the Apple Watch devices.
  case watch
  ///  The image is for CarPlay.
  case car
  case macCatalyst
}
