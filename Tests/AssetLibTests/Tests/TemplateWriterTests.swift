import AssetLib
import XCTest

final class TemplateWriterTests: XCTestCase {
  fileprivate func templateTest(_ result: TemplateResult) {
    let expected = Data((0 ... 255).map { _ in UInt8.random(in: 0 ... UInt8.max) })
    let encoder = MockEncoder(data: expected)
    let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    let writer = TemplateWriter(encoder: encoder)
    let actual: Data
    do {
      try writer.saveTemplateResult(result, to: url)

      actual = try Data(contentsOf: url)
    } catch {
      XCTFail(error.localizedDescription)
      return
    }
    XCTAssertEqual(expected, actual)
  }

  func testError() {
    let writer = TemplateWriter()
    let mockError = MockError()
    XCTAssert(writer.encoder is JSONEncoder)
    let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    do {
      try writer.saveTemplateResult(.failure(mockError), to: url)

    } catch {
      XCTAssertEqual(mockError.localizedDescription, error.localizedDescription)
      return
    }
    XCTFail("Should be an error")
  }

  func testSaveTemplateResult() {
    templateTest(.appicon(AppIconTemplate(devices:
      [.car, .ipad, .iphone, .mac, .tv, .watch],
                                          specifyGamut: true,
                                          prerendered: true)))
    templateTest(.imageset(ImageSetTemplate(
      templateRenderingIntent: .template,
      devices: [.ipad, .iphone],
      locales: [.init(identifier: "en"), .init(identifier: "fr")]
    )))
  }
}
