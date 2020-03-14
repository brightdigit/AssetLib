@testable import AssetLib
import XCTest
@objc class SortedDictionary: NSDictionary {
  let values: NSMutableArray = []
  let keys: NSMutableOrderedSet = []

  override var count: Int {
    return keys.count
  }

  override func keyEnumerator() -> NSEnumerator {
    return keys.objectEnumerator()
  }

  override func object(forKey aKey: Any) -> Any? {
    let index = keys.index(of: aKey)
    if index != NSNotFound {
      return values[index]
    }
    return nil
  }

  private func setObject(_ anObject: Any, forKey aKey: String) {
    let index = keys.index(of: aKey)
    if index != NSNotFound {
      values[index] = convertObject(anObject)
    } else {
      keys.add(aKey)
      values.add(convertObject(anObject))
    }
  }

  private func convertObject(_ object: Any) -> Any {
    if let dict = object as? [String: Any] {
      return SortedDictionary(dict)
    } else if let array = object as? [Any] {
      return array.map {
        convertObject($0)
      }
    } else {
      return object
    }
  }

  @objc convenience init(_ dictionary: [String: Any]) {
    self.init()
    dictionary.sorted {
      $0.0.compare($1.0, options: [.caseInsensitive, .forcedOrdering]) == .orderedAscending
    }
    .forEach {
      self.setObject($0.value, forKey: $0.key)
    }
  }
}

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
    if #available(OSX 10.13, *) {
      if let data = try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .prettyPrinted]) {
        return data
      }
    } else {
      // force ordering

      // let orderedJson = SortedDictionary(object)

      // write pretty printed
//      _ = JSONSerialization.writeJSONObject(orderedJson, to: outputJSON, options: [.prettyPrinted], error: nil)

      if let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) {
        return data
      }
    }
    return nil
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
    for index in 0 ..< count where components1[index] != components2[index] {
      return index
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
    for index in 0 ..< count {
      let translatedIndex = count - 1 - index
      if self[translatedIndex] is NSNull {
        remove(at: translatedIndex)
      } else if let array = self[translatedIndex] as? [Any] {
        self[translatedIndex] = array.strippingNulls()
      } else if let dictionary = self[translatedIndex] as? [String: Any] {
        self[translatedIndex] = dictionary.strippingNulls()
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
  func testSuccessful() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../Data/Data")
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let documents = contentsJSONUrls.compactMap { url -> (URL, AssetSpecificationDocument, Data)? in
      do {
        let data = try Data(contentsOf: url)
        return try (url, decoder.decode(AssetSpecificationDocument.self, from: data), data)
      } catch {
        XCTFail("\(url): \(error.localizedDescription)")
        return nil
      }
    }

    XCTAssertGreaterThan(contentsJSONUrls.count, 0)
    XCTAssertEqual(contentsJSONUrls.count, documents.count)
    let contentsEncodeds = documents.compactMap { arg -> (URL, Data)? in
      do {
        let data = try encoder.encode(arg.1)
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
      guard let expectedData = expected[url] else {
        XCTFail("No expected data for \(url)")
        continue
      }
      XCTAssertNil(Data.jsonMismatch(lhs: data, rhs: expectedData), "Mismatch at \(url)")
    }
  }

  fileprivate func testInvalidJSON(_ dataDirectoryUrl: URL, _ errorKey: String) {
    let enumerator = FileManager.default.enumerator(at: dataDirectoryUrl, includingPropertiesForKeys: nil)

    let contentsJSONUrls = enumerator!.compactMap { $0 as? URL }.filter { $0.pathExtension == "json" }

    let decoder = JSONDecoder()
    XCTAssertGreaterThan(contentsJSONUrls.count, 0)
    for url in contentsJSONUrls {
      var errorOpt: Error?
      do {
        let data = try Data(contentsOf: url)
        XCTAssertThrowsError(try decoder.decode(AssetSpecificationDocument.self, from: data)) {
          errorOpt = $0
        }
      } catch {
        XCTFail("\(url): \(error.localizedDescription)")
        continue
      }
      guard let error = errorOpt else {
        XCTFail("\(url): did not catch error")
        continue
      }
      guard let decodingError = error as? DecodingError else {
        XCTFail("\(url): \(error.localizedDescription)")
        continue
      }
      XCTAssertEqual(decodingError.keyString, errorKey)
    }
  }

  func testInvalidScale() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../Data/InvalidScale")
    testInvalidJSON(dataDirectoryUrl, "scale")
  }

  func testInvalidSize() {
    let hereUrl = URL(fileURLWithPath: #file)
    let dataDirectoryUrl = hereUrl.deletingLastPathComponent().appendingPathComponent("../../Data/InvalidSize")
    testInvalidJSON(dataDirectoryUrl, "size")
  }

  func testMetadata() {
    let author = "test"
    let version = 2

    XCTAssertEqual(AssetSpecificationMetadata(author: author, version: version).author, author)
    XCTAssertEqual(AssetSpecificationMetadata(author: author, version: version).version, version)

    XCTAssertEqual(AssetSpecificationMetadata(author: author).author, author)
    XCTAssertEqual(AssetSpecificationMetadata(author: author).version, AssetSpecificationMetadata.defaultVersion)

    XCTAssertEqual(AssetSpecificationMetadata().author, AssetSpecificationMetadata.xcodeAuthor)
    XCTAssertEqual(AssetSpecificationMetadata().version, AssetSpecificationMetadata.defaultVersion)
  }

  func testSpecifications() {
    let idiom = ImageIdiom.car
    let scale = CGFloat.random(in: 1 ... 3)
    let sizeDimension = CGFloat.random(in: 20 ... 200)
    let size = CGSize(width: sizeDimension, height: sizeDimension)
    let role = AppleWatchRole.companionSettings
    let subtype = AppleWatchType.size40
    let filename = "test.png"

    let specifications = AssetSpecification(idiom: idiom, scale: scale, size: size, role: role, subtype: subtype, filename: filename)

    XCTAssertEqual(specifications.idiom, idiom)
    XCTAssertEqual(specifications.scale, scale)
    XCTAssertEqual(specifications.size, size)
    XCTAssertEqual(specifications.role, role)
    XCTAssertEqual(specifications.subtype, subtype)
    XCTAssertEqual(specifications.filename, filename)

    XCTAssertEqual(AssetSpecification(idiom: idiom).scale, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).size, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).role, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).subtype, nil)
    XCTAssertEqual(AssetSpecification(idiom: idiom).filename, nil)
  }

  func testDecodingError() {
    let error = DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [CodingKey](), debugDescription: ""))
    XCTAssertNil(error.keyString)
  }
}
