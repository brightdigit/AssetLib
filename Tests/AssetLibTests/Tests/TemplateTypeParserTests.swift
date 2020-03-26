import AssetLib
import XCTest

final class TemplateDetailsFactoryTests: XCTestCase {
  func testDetails() {
    let parser = TemplateTypeParser()
    XCTAssertEqual(parser.templateType(fromPath: "Image.imageset"), .imageset)
    XCTAssertEqual(parser.templateType(fromPath: "Image.appiconset"), .appicon)
    XCTAssertEqual(parser.templateType(fromPath: UUID().uuidString), nil)
  }
}
