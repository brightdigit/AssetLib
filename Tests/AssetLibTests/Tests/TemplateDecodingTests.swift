import AssetLib
import Foundation
import XCTest

final class TemplateDecodingTests: XCTestCase {
  func testTemplateCodable() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../../Example/Templates")
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    _ = contentsJSONUrls.compactMap { url -> (URL, Any, Data)? in
      guard let prefix = url.lastPathComponent.components(separatedBy: "-").first else {
        XCTFail("Invalid file name \(url)")
        return nil
      }
      do {
        let data = try Data(contentsOf: url)

        if prefix == "appicon" {
          return try (url, decoder.decode(AppIconTemplate.self, from: data), data)
        } else if prefix == "imageset" {
          return try (url, decoder.decode(ImageSetTemplate.self, from: data), data)

        } else {
          // XCTFail("Invalid file name \(url)")
          return nil
        }

      } catch {
        XCTFail("\(url): \(error.localizedDescription)")
        return nil
      }
    }
  }
}
