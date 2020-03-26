import AssetLib
import XCTest

public struct MockEncoder: TemplateEncoder {
  public let data: Data
  public func encode<T>(_: T) throws -> Data where T: Encodable {
    return data
  }
}

final class TemplateWriterTests: XCTestCase {
  func testSaveTemplateResult() {
    let expected = Data((0 ... 255).map { _ in UInt8.random(in: 0 ... UInt8.max) })
    let encoder = MockEncoder(data: expected)
    let url = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(UUID().uuidString)
    let writer = TemplateWriter(encoder: encoder)
    let actual: Data
    do {
      try writer.saveTemplateResult(
        .appicon(AppIconTemplate(devices:
          [.car, .ipad, .iphone, .mac, .tv, .watch],
                                 specifyGamut: true,
                                 prerendered: true)), to: url
      )

      actual = try Data(contentsOf: url)
    } catch {
      XCTFail(error.localizedDescription)
      return
    }
    XCTAssertEqual(expected, actual)
  }
}
