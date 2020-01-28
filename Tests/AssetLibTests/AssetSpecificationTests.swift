@testable import AssetLib
import XCTest

final class AssetSpecificationTests: XCTestCase {
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    // XCTAssertEqual(AssetLib().text, "Hello, World!")
    // print(Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil, localization: nil))
    // print(#file)
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("Data")
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let documents = contentsJSONUrls.compactMap {
      url -> (URL, AssetSpecificationDocument, String)? in
      do {
        let data = try Data(contentsOf: url)
        return try String(data: data, encoding: .utf8).map{
          try (url, decoder.decode(AssetSpecificationDocument.self, from: data), $0)
        }
      }
      catch let error {
        XCTFail("\(url): \(error.localizedDescription)")
        return nil
      }
    }
    
    XCTAssertEqual(contentsJSONUrls.count, documents.count)
//    let documents = contentsJSONDatas.map {
//      do {
//        try decoder.decode(AssetSpecificationDocument.self, from: $0)
//      }
//      catch let error {
//
//      }
//    }
//    XCTAssertEqual(contentsJSONUrls.count, documents.count)
    let contentsEncodeds = documents.compactMap {
      arg -> (URL, String)? in
      do {
        let data = try encoder.encode(arg.1)
        return String(data: data, encoding: .utf8).map{
          (arg.0, $0)
        }
      } catch let error {
        XCTFail("\(arg.0): \(error.localizedDescription)")
        return nil
      }
    }
    XCTAssertEqual(documents.count, contentsEncodeds.count)
    
    let expected = Dictionary(grouping: documents) { $0.0 }.compactMapValues{ $0.first?.2}
    let actual = Dictionary(grouping: contentsEncodeds) { $0.0 }.compactMapValues{ $0.first?.1 }
  
    XCTAssertEqual(expected, actual)
    //XCTAssertEqual(contentsJSONDatas, contentsEncodeds)
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
