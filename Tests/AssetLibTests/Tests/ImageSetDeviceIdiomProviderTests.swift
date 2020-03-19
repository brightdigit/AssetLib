
@testable import AssetLib
import XCTest

final class ImageSetDeviceIdiomProviderTests: XCTestCase {
  func testSuccessful() {
    let dictionary : [ImageSetDevice : (ImageIdiom, DeviceSubType?)]
    dictionary = [
      :
    ]
    let imageSetIdiomProvider = ImageSetDeviceIdiomProvider(dictionary: dictionary)
}
}
