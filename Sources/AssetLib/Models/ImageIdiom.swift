import Foundation

public enum ImageIdiom: String, Codable {
  case universal,
    iphone,
    ipad,
    mac,
    // swiftlint:disable:next identifier_name
    tv,
    watch,
    car,
    watchMarketing = "watch-marketing",
    iosMarketing = "ios-marketing"
}
