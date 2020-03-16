@testable import AssetLib
import XCTest

final class AssetTemplateTests: XCTestCase {
  func testTemplate() {
    let template = AssetTemplate(configuration: AppIconTemplateConfiguration(devices: Set<ImageIdiom>(), specifyGamut: false, prerendered: true))
  }
}
