@testable import AssetLib
import XCTest

final class AssetSpecificationTests: XCTestCase {
  func testExample() {
    
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.
    // XCTAssertEqual(AssetLib().text, "Hello, World!")
    //print(Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil, localization: nil))
    //print(#file)
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("Data")
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)
    
    let contentsJSONUrls = enumerator!.compactMap{ $0 as? URL }.filter{ $0.pathExtension == "json" }
    
    let decoder = JSONDecoder()
    let contentsJSONDatas = contentsJSONUrls.compactMap{
      try? Data(contentsOf: $0)
    }
    let documents = contentsJSONDatas.compactMap{
      try? decoder.decode(AssetSpecificationDocument.self, from: $0)
    }
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
