import AssetLib
import XCTest

final class ISDeviceIdiomProviderTests: XCTestCase {
  func testValidDictionary() {
    var dictionary = [ImageSetDevice: (ImageIdiom, DeviceSubType?)]()
    for device in ImageSetDevice.allCases {
      let value: (ImageIdiom, DeviceSubType?)
      switch device {
      case .universal:
        value = (ImageIdiom.universal, nil)
      case .iphone:
        value = (ImageIdiom.iphone, nil)
      case .ipad:
        value = (ImageIdiom.ipad, nil)
      case .mac:
        value = (ImageIdiom.mac, nil)
      case .tv:
        value = (ImageIdiom.tv, nil)
      case .watch:
        value = (ImageIdiom.watchMarketing, .size42)
      case .car:
        value = (ImageIdiom.car, nil)
      case .macCatalyst:
        value = (ImageIdiom.iphone, .macCatalyst)
      }
      dictionary[device] = value
    }
    let imageSetIdiomProvider = ISDeviceIdiomProvider(dictionary: dictionary)

    XCTAssertNotNil(imageSetIdiomProvider)

    guard let idiomProvider = imageSetIdiomProvider else {
      return
    }
    for device in ImageSetDevice.allCases {
      let actual = idiomProvider.idiom(forDevice: device)
      let expected = dictionary[device]
      XCTAssertEqual(actual?.0, expected?.0)
      XCTAssertEqual(actual?.1, expected?.1)
    }
  }

  func testInvalidDictionary() {
    let dictionary: [ImageSetDevice: (ImageIdiom, DeviceSubType?)]
    dictionary = [
      .ipad: (ImageIdiom.watchMarketing, .size42)
    ]
    let imageSetIdiomProvider = ISDeviceIdiomProvider(dictionary: dictionary)

    XCTAssertNil(imageSetIdiomProvider)
  }
}
