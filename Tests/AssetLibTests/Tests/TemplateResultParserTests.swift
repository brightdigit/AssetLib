import AssetLib
import XCTest

final class TemplateResultParserTests: XCTestCase {
  fileprivate func data(_: URL) -> Data {
    Data()
  }

  fileprivate func XCTAssertParser(
    _ parser: TemplateResultParser,
    _ type: TemplateType?,
    _ expectedType: TemplateType?,
    _ error: Error,
    _ actual: Any?
  ) {
    let result = parser.template(
      fromURL: URL(fileURLWithPath: NSTemporaryDirectory()),
      withType: type
    )

    if expectedType == type || type == nil {
      switch expectedType {
      case .none:
        XCTAssertEqual(result, .failure(error))

      default:

        XCTAssertEqual(result, TemplateResult(actual))
      }
    } else {
      XCTAssertEqual(result, .failure(error))
    }
  }

  fileprivate func resultTestWith(_ expectedType: TemplateType?) {
    let parser: TemplateResultParser
    let actual: Any?
    let error: Error
    error = MockError()
    switch expectedType {
    case .some(.appicon):
      let template = AppIconTemplate()

      parser = TemplateResultParser(
        parser: MockDecoder(result: template, error: error),
        reader: data
      )
      actual = template

    case .some(.imageset):
      let template = ImageSetTemplate()
      parser = TemplateResultParser(
        parser: MockDecoder(result: template, error: error),
        reader: data
      )
      actual = template

    case .none:
      parser = TemplateResultParser(
        parser: ErrorDecoder(error: error),
        reader: data
      )
      actual = nil
    }

    let types: [TemplateType?] = [.appicon, .imageset, nil]
    for type in types {
      XCTAssertParser(parser, type, expectedType, error, actual)
    }
  }

  func testTemplate() {
    resultTestWith(.appicon)
    resultTestWith(.imageset)
    resultTestWith(nil)
  }
}
