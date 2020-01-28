@testable import AssetLib
import XCTest

@available(OSX 10.13, iOS 11, *)
public extension Data {
  func jsonSerialized() -> Data? {
    guard let json = try? JSONSerialization.jsonObject(with: self) else {
      return nil
    }
    let object: Any = {
      if let array = json as? [Any] {
        return array.strippingNulls()
      } else if let dictionary = json as? [String: Any] {
        return dictionary.strippingNulls()
      } else {
        return json
      }
    }()
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .prettyPrinted]) else {
      return nil
    }
    return data
  }

  static func jsonMismatch(lhs: Data, rhs: Data, alreadySerialized: Bool = false) -> Int? {
    switch alreadySerialized {
    case true:
      return _jsonMismatch(lhs: lhs, rhs: rhs)
    case false:
      guard let lhs = lhs.jsonSerialized(), let rhs = rhs.jsonSerialized() else {
        return nil
      }
      return _jsonMismatch(lhs: lhs, rhs: rhs)
    }
  }

  private static func _jsonMismatch(lhs: Data, rhs: Data) -> Int? {
    guard let string1 = String(data: lhs, encoding: .utf8), let string2 = String(data: rhs, encoding: .utf8) else {
      return nil
    }
    let components1 = string1.components(separatedBy: "\n")
    let components2 = string2.components(separatedBy: "\n")
    let count = components1.count < components2.count ? components1.count : components2.count
    for index in 0 ..< count {
      if components1[index] != components2[index] {
        return index
      }
    }
    return nil
  }
}

private extension Array where Element == Any {
  func strippingNulls() -> Array {
    var array = self
    array.stripNulls()
    return array
  }

  mutating func stripNulls() {
    let count = self.count
    guard count > 0 else {
      return
    }
    for _index in 0 ..< count {
      let index = count - 1 - _index
      if self[index] is NSNull {
        remove(at: index)
      } else if let array = self[index] as? [Any] {
        self[index] = array.strippingNulls()
      } else if let dictionary = self[index] as? [String: Any] {
        self[index] = dictionary.strippingNulls()
      }
    }
  }
}

private extension Dictionary where Key == String, Value == Any {
  func strippingNulls() -> Dictionary {
    var dictionary = self
    dictionary.stripNulls()
    return dictionary
  }

  mutating func stripNulls() {
    for (key, value) in self {
      if value is NSNull {
        removeValue(forKey: key)
      } else if let array = value as? [Any] {
        self[key] = array.strippingNulls()
      } else if let dictionary = value as? [String: Any] {
        self[key] = dictionary.strippingNulls()
      }
    }
  }
}

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
    encoder.outputFormatting = .prettyPrinted
    let documents = contentsJSONUrls.compactMap {
      url -> (URL, AssetSpecificationDocument, Data)? in
      do {
        let data = try Data(contentsOf: url)
//        return try String(data: data, encoding: .utf8).map{
//          try (url, decoder.decode(AssetSpecificationDocument.self, from: data), $0)
//        }
        return try (url, decoder.decode(AssetSpecificationDocument.self, from: data), data)
      } catch {
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
      arg -> (URL, Data)? in
      do {
        let data = try encoder.encode(arg.1)
//        return String(data: data, encoding: .utf8).map{
//          (arg.0, $0)
//        }
        return (arg.0, data)
      } catch {
        XCTFail("\(arg.0): \(error.localizedDescription)")
        return nil
      }
    }
    XCTAssertEqual(documents.count, contentsEncodeds.count)

    let expected = Dictionary(grouping: documents) { $0.0 }.compactMapValues { $0.first?.2 }
    let actual = Dictionary(grouping: contentsEncodeds) { $0.0 }.compactMapValues { $0.first?.1 }

    XCTAssertEqual(expected.count, actual.count)

    for (url, data) in actual {
      // XCTAssertEqual(text, expected[url])
      guard let expectedData = expected[url] else {
        XCTFail("No expected data for \(url)")
        continue
      }
      if #available(OSX 10.13, iOS 11, *) {
        XCTAssertNil(Data.jsonMismatch(lhs: data, rhs: expectedData), "Mismatch at \(url)")
      } else {
        // Fallback on earlier versions
        #warning("support other OSes")
        XCTFail("unsupported OS")
      }
    }
  }

  static var allTests = [
    ("testExample", testExample)
  ]
}
