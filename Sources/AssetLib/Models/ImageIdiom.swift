import Foundation

public enum ImageIdiom: String, Codable {
  case universal
  case iphone
  case ipad
  case mac
    // swiftlint:disable:next identifier_name
  case tv
  case watch
  case car
  case watchMarketing = "watch-marketing"
  case iosMarketing = "ios-marketing"
}
