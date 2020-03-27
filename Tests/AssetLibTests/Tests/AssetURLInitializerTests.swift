import AssetLib
import XCTest

final class AssetURLInitializerTests: XCTestCase {
  fileprivate func assetURLTest(_ path: String, _ type: TemplateType?, _ shouldCreateDirectory: Bool) {
    var didCreateDirectory = false
    let assetURLInitializer = AssetURLInitializer { _ in didCreateDirectory = true }
    let actualURL: URL
    do {
      actualURL = try assetURLInitializer.url(fromPath: path, withType: type)
    } catch {
      XCTFail(error.localizedDescription)
      return
    }
    var expectedURL = URL(fileURLWithPath: path, isDirectory: shouldCreateDirectory)
    if shouldCreateDirectory {
      expectedURL.appendPathComponent("Contents.json")
    }
    XCTAssertEqual(actualURL, expectedURL)
    XCTAssertEqual(didCreateDirectory, shouldCreateDirectory)
  }

  func testSuccessful() {
    assetURLTest(UUID().uuidString, TemplateType.appicon, true)
    assetURLTest(UUID().uuidString, TemplateType.imageset, true)
    assetURLTest(UUID().uuidString, nil, false)
  }
}
